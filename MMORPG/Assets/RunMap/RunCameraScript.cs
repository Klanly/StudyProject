using UnityEngine;
using System.Collections;

public class RunCameraScript : MonoBehaviour {
	
	public static RunCameraScript instance;
	
	public Transform cameraPivot;
	
	public float mouseSpeed = 0.15f;
	public float mouseScroll = 15f;
	public float mouseSmoothingFactor = 0.08f;
	public float camDistanceSpeed = 0.7f;
	public float camBottomDistance = 1f;
	public float minY = 80;
	public float maxY = 50;
	public float maxDistance = 8;
	public float minDistance = 5f;
	public float selfMinY = 29.5f;
	
	private float distance = 8f;
	private Vector3 desiredPosition;
	private float desiredDistance;
	private float lastDistance;
	public float mouseX = 0f;
	private float mouseXSmooth = 0f;
	private float mouseXVel;
	public float mouseY = 0f;
	private float mouseYSmooth = 0f;
	private float mouseYVel;
	private float mouseYMin = -70f;
	private float mouseYMax = 50f;
	private float distanceVel;
	private bool camBottom;
	
	private Vector3 oldPosition1,oldPosition2;
	
	public bool isActive = true;
	
	public Transform targetParent;
	private const float meshSizeY = 1.65f;
	
	public bool useDefault = true;
	public bool lockYRotate = false;
	public bool isRange = false;
	public float minX = 128.5f;
	public float maxX = 284.5f;
	
	void Awake() 
	{
		instance = this;
	}
	
	void Start()
	{
		desiredDistance = distance;
		if (useDefault) 
		{
			isActive = true;
			mouseX = 180f;
			mouseY = 15f;
		}
		else 
		{
			mouseYSmooth = mouseY;
			mouseXSmooth = mouseX + 40;
			desiredDistance = maxDistance;
			lastDistance = maxDistance;
		}
	}
	
	void OnDisable()
	{
		this.PositionUpdate ();
	}
	void LateUpdate() {
		if (cameraPivot == null) {
			Debug.Log("Error: No cameraPivot found! Please read the manual for further instructions.");
			return;
		}
		CalcCameraY ();
		GetInput();
		
		GetDesiredPosition();
		
		PositionUpdate();
	}
	public void ResetCameraY(Transform trans)
	{
		targetParent = trans;
	}
	private void CalcCameraY()
	{
		if (transform != null && cameraPivot != null && targetParent != null) 
		{
			cameraPivot.position = targetParent.position + Vector3.up * meshSizeY;
			//			selfMinY = cameraPivot.position.y - meshSizeY + 0.3f;
			//			selfMinY = Mathf.FloorToInt (selfMinY) + 1;
			selfMinY = cameraPivot.position.y - 0.7f;
		}
	}
	
	public void OnFingerDrag(Vector2 vel)
	{
		if (isActive)
		{
			bool constrainMouseY = camBottom && transform.position.y - cameraPivot.transform.position.y <= 0;
			mouseX += vel.x * mouseSpeed * 2 ;
			mouseSmoothingFactor = 0.08f;
			
			if(isRange)
				mouseX = Mathf.Clamp(mouseX,minX,maxX);
			
			if(!lockYRotate)
			{
				if (constrainMouseY) 
				{
					if (Input.GetAxis("Mouse Y") < 0)
						mouseY -= vel.y * mouseSpeed ;
				} else
					mouseY -= vel.y * mouseSpeed;
			}
		}
	}
	
	
	
	
	void GetInput()
	{
		if (isActive)
		{
			if (distance > 0.1)
			{
				#if UNITY_EDITOR
				// distance > 0.05 would be too close, so 0.1 is fine
				Debug.DrawLine(transform.position, transform.position - Vector3.up * camBottomDistance, Color.green);
				#endif
				camBottom = Physics.Linecast(transform.position, transform.position - Vector3.up * camBottomDistance);
			}
			
			bool constrainMouseY = camBottom && transform.position.y - cameraPivot.transform.position.y <= 0;
			
			mouseY = ClampAngle(mouseY, -minY, maxY);
			mouseXSmooth = Mathf.SmoothDamp(mouseXSmooth, mouseX, ref mouseXVel, mouseSmoothingFactor);
			mouseYSmooth = Mathf.SmoothDamp(mouseYSmooth, mouseY, ref mouseYVel, mouseSmoothingFactor);
			
			if (constrainMouseY)
				mouseYMin = mouseY;
			else
				mouseYMin = -minY;
			
			mouseYSmooth = ClampAngle(mouseYSmooth, mouseYMin, mouseYMax);
			
			desiredDistance = Mathf.Clamp (desiredDistance, minDistance, maxDistance);	
		}
	}
	
	void GetDesiredPosition()
	{
		if (Camera.main != null)
		{
			distance = desiredDistance;
			desiredPosition = GetCameraPosition(mouseYSmooth, mouseXSmooth, distance);
			distance -= Camera.main.nearClipPlane;
			
			distance = Mathf.SmoothDamp(lastDistance, distance, ref distanceVel, camDistanceSpeed);
			
			if (distance < 0.05)
				distance = 0.05f;
			lastDistance = distance;
			
			desiredPosition = GetCameraPosition(mouseYSmooth, mouseXSmooth, distance); // if the camera view was blocked, then this is the new "forced" position
			if (desiredPosition.y <selfMinY)
				desiredPosition.y = selfMinY;
		}
	}
	
	
	void PositionUpdate() {
		transform.position = desiredPosition;
		if (distance > 0.05)
			transform.LookAt(cameraPivot);
	}
	
	
	Vector3 GetCameraPosition(float xAxis, float yAxis, float distance) {
		Vector3 offset = new Vector3(0, 0, -distance);
		Quaternion rotation = Quaternion.Euler(xAxis, yAxis, 0);
		return cameraPivot.position + rotation * offset;
	}	
	
	float ClampAngle(float angle, float min, float max) {
		while (angle < -360 || angle > 360) {
			if (angle < -360)
				angle += 360;
			if (angle > 360)
				angle -= 360;
		}
		
		return Mathf.Clamp(angle, min, max);
	}
}
