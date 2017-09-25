using UnityEngine;
using System.Collections;

public class RunMap : MonoBehaviour
{
    public Vector3 mCurCameraPos = new Vector3(0, 5.5f, 6.4f);
    public Vector3 mChangeCameraPos = new Vector3(0, 5.5f, 6.4f);
  
    public float mPlayerChangeHeight = 0.5f;
    public float mPlayerHeight = 0.5f;
    public float mPlayerSize = 1.0f;

    public float mCameraMoveSpeed = 30.0f;
    protected bool mIsMoving;

    private Rigidbody m_Rigidbody;
    private Animator m_Animator;

    private Vector3 m_Move, m_CamForward;

    public float dis = 5.0f;

    public float rotateY = 0;
    public float rotateX = 0;
    public bool unlock = true;
    public float MoveSpeed = 0.3f;
    public float MoverotateY = 0.3f;
    // Use this for initialization
    public float moveSpeed = 8.0f;
    public float moveSpeed2 = 10;
    private float movespeed
    {
        set
        {
            MoveSpeed = value;
        }
    }
    public float mouseX = 0f;
    public float mouseY = 0f;
    private const float meshSizeY = 1.65f;
    public bool zc = true;
    public bool showOperation = true;
    public GameObject cameraPivot;
    public bool setSpeed = false;
    private RunCameraScript mRunCameraScript;
    void Start()
    {

        m_Animator = GetComponent<Animator>();
        m_Rigidbody = GetComponent<Rigidbody>();
        m_Rigidbody.constraints = RigidbodyConstraints.FreezeRotationX | RigidbodyConstraints.FreezeRotationY | RigidbodyConstraints.FreezeRotationZ |
                                  RigidbodyConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionZ;

        mRunCameraScript = Camera.main.gameObject.GetComponent<RunCameraScript>();
        if (mRunCameraScript == null)
        {
            mRunCameraScript = Camera.main.gameObject.AddComponent<RunCameraScript>();
            mRunCameraScript.cameraPivot = cameraPivot.transform;
        }
    }
    void OnGUI()
    {
        if (showOperation)
        {
            if (GUI.Button(new Rect(0, 0, 100, 50), "切换到主城镜头"))
            {
                zc = true;
                unlock = false;
                setSpeed = false;
                movespeed = 0.3f;
            }
            if (GUI.Button(new Rect(0, 50, 100, 50), "切换到副本镜头"))
            {
                zc = false;
                unlock = false;
                setSpeed = false;
                movespeed = 0.3f;
            }
            if (GUI.Button(new Rect(0, 100, 100, 50), "切换到美术跑图镜头"))
            {
                zc = false;
                unlock = true;
                setSpeed = true;
            }
        }
        if (setSpeed)
        {
            if (GUI.Button(new Rect(0, 150, 100, 50), "加速"))
            {
                MoveSpeed += 1;
                if (MoveSpeed > 30)
                {
                    movespeed = 30;
                }
                else if (MoveSpeed < 0)
                {
                    movespeed = 0;
                }
            }
            if (GUI.Button(new Rect(0, 200, 100, 50), "减速"))
            {
                MoveSpeed -= 1;
                if (MoveSpeed > 30)
                {
                    movespeed = 30;
                }
                else if (MoveSpeed < 0)
                {
                    movespeed = 0;
                }
            }
        }
    }
    void SetCameraEx()
    {
        if (mChangeCameraPos == Vector3.zero)
            mChangeCameraPos = mCurCameraPos;

        if (!Vector3.Equals(mCurCameraPos, mChangeCameraPos))
        {
            mCurCameraPos = Vector3.MoveTowards(mCurCameraPos, mChangeCameraPos, Time.deltaTime * moveSpeed);
        }

        if (mPlayerChangeHeight != mPlayerHeight)
        {
            mPlayerHeight += (mPlayerChangeHeight - mPlayerHeight) / moveSpeed2;
        }

        if (Camera.main != null)
        {
            Camera.main.transform.position = transform.position + mCurCameraPos;
            Camera.main.transform.LookAt(transform.position + Vector3.up * mPlayerHeight);
        }
    }
    private void FixedUpdate()
    {
        // read inputs
        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
        m_Move = v * Vector3.forward + h * Vector3.right;
        if (m_Move.magnitude > 1f)
            m_Move.Normalize();

        m_Move = transform.InverseTransformDirection(m_Move);

        // calculate move direction to pass to character
        if (Camera.main != null)
        {
            // calculate camera relative direction to move:
            m_CamForward = Vector3.Scale(Camera.main.transform.forward, new Vector3(1, 0, 1)).normalized;
            m_Move = v * m_CamForward + h * Camera.main.transform.right;

        }
        else
        {
            // we use world-relative directions in the case of no main camera
            m_Move = v * Vector3.forward + h * Vector3.right;
        }

        if (!m_Move.Equals(Vector3.zero))
        {
            transform.localRotation = Quaternion.LookRotation(m_Move);
            m_Animator.SetBool("Run", true);
        }
        else
            m_Animator.SetBool("Run", true);

        transform.localPosition += m_Move * MoveSpeed;

        if (Input.GetMouseButton(0))
        {
            if (unlock == true)
            {
                rotateX += Input.GetAxis("Mouse X");
            }
        }

        if (Input.GetMouseButton(1))
        {
            rotateY += Input.GetAxis("Mouse Y");

            if (rotateY > 50)
                rotateY = 50;

            if (rotateY < 0)
                rotateY = 0;
        }
        if (Camera.main != null)
        {
            if (zc == true)
            {
                mRunCameraScript.enabled = true;
            }
            else
            {
                mRunCameraScript.enabled = false;
                if (unlock == true)
                {
                    float d = -dis - rotateY * MoverotateY;


                    Vector3 rot = new Vector3(Mathf.Sin(rotateX) * d, Mathf.Tan(rotateY / 180.0f * Mathf.PI) * rotateY * 0.1f, Mathf.Cos(rotateX) * d);

                    Camera.main.transform.localPosition = transform.localPosition + Vector3.up * 2.0f + rot;
                    Camera.main.transform.LookAt(transform.localPosition + Vector3.up * 2.0f);
                }
                else
                {
                    SetCameraEx();
                }
            }

        }
    }
}