// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.04 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.04;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,rprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:1,culm:2,dpts:2,wrdp:True,dith:2,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:6406,x:33217,y:32577,varname:node_6406,prsc:2|spec-9089-RGB,emission-1439-OUT,clip-7421-A;n:type:ShaderForge.SFN_Tex2d,id:7421,x:32785,y:32464,ptovrint:False,ptlb:main,ptin:_main,varname:node_7421,prsc:2,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9089,x:32590,y:32849,ptovrint:False,ptlb:mask,ptin:_mask,varname:node_9089,prsc:2,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8161,x:32367,y:32786,ptovrint:False,ptlb:liudong,ptin:_liudong,varname:node_8161,prsc:2,ntxv:0,isnm:False|UVIN-698-OUT;n:type:ShaderForge.SFN_Multiply,id:2377,x:32829,y:32909,varname:node_2377,prsc:2|A-5288-OUT,B-9089-RGB;n:type:ShaderForge.SFN_Add,id:1439,x:33007,y:32799,varname:node_1439,prsc:2|A-7421-RGB,B-2377-OUT;n:type:ShaderForge.SFN_Vector1,id:1796,x:32252,y:32650,varname:node_1796,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:5288,x:32610,y:32630,varname:node_5288,prsc:2|A-1796-OUT,B-8161-RGB,C-773-RGB;n:type:ShaderForge.SFN_Color,id:773,x:32252,y:32468,ptovrint:False,ptlb:liuqv_color,ptin:_liuqv_color,varname:node_773,prsc:2,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Append,id:9202,x:31611,y:32823,varname:node_9202,prsc:2|A-5550-OUT,B-1370-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5550,x:31400,y:32794,ptovrint:False,ptlb:U,ptin:_U,varname:node_5550,prsc:2,glob:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:1370,x:31400,y:32910,ptovrint:False,ptlb:V,ptin:_V,varname:node_1370,prsc:2,glob:False,v1:0;n:type:ShaderForge.SFN_Time,id:8961,x:31600,y:32645,varname:node_8961,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1644,x:31839,y:32792,varname:node_1644,prsc:2|A-8961-T,B-9202-OUT;n:type:ShaderForge.SFN_Add,id:698,x:32033,y:32777,varname:node_698,prsc:2|A-4964-UVOUT,B-1644-OUT;n:type:ShaderForge.SFN_TexCoord,id:4964,x:31839,y:32591,varname:node_4964,prsc:2,uv:0;proporder:7421-9089-8161-773-5550-1370;pass:END;sub:END;*/

Shader "Shader Forge/Model_liuguang" {
    Properties {
        _main ("main", 2D) = "white" {}
        _mask ("mask", 2D) = "white" {}
        _liudong ("liudong", 2D) = "white" {}
        _liuqv_color ("liuqv_color", Color) = (0.5,0.5,0.5,1)
        _U ("U", Float ) = 0
        _V ("V", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _main; uniform float4 _main_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform sampler2D _liudong; uniform float4 _liudong_ST;
            uniform float4 _liuqv_color;
            uniform float _U;
            uniform float _V;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(unity_ObjectToWorld, float4(v.normal,0)).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float4 _main_var = tex2D(_main,TRANSFORM_TEX(i.uv0, _main));
                clip(_main_var.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float3 specularColor = _mask_var.rgb;
                float3 directSpecular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow);
                float3 specular = directSpecular * specularColor;
////// Emissive:
                float4 node_8961 = _Time + _TimeEditor;
                float2 node_698 = (i.uv0+(node_8961.g*float2(_U,_V)));
                float4 _liudong_var = tex2D(_liudong,TRANSFORM_TEX(node_698, _liudong));
                float3 emissive = (_main_var.rgb+((2.0*_liudong_var.rgb*_liuqv_color.rgb)*_mask_var.rgb));
/// Final Color:
                float3 finalColor = specular + emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform sampler2D _main; uniform float4 _main_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform sampler2D _liudong; uniform float4 _liudong_ST;
            uniform float4 _liuqv_color;
            uniform float _U;
            uniform float _V;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(unity_ObjectToWorld, float4(v.normal,0)).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                
                float nSign = sign( dot( viewDirection, i.normalDir ) ); // Reverse normal if this is a backface
                i.normalDir *= nSign;
                normalDirection *= nSign;
                
                float4 _main_var = tex2D(_main,TRANSFORM_TEX(i.uv0, _main));
                clip(_main_var.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = 0.5;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float3 specularColor = _mask_var.rgb;
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow);
                float3 specular = directSpecular * specularColor;
/// Final Color:
                float3 finalColor = specular;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCollector"
            Tags {
                "LightMode"="ShadowCollector"
            }
            Cull Off
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCOLLECTOR
            #define SHADOW_COLLECTOR_PASS
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcollector
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _main; uniform float4 _main_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_COLLECTOR;
                float2 uv0 : TEXCOORD5;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_COLLECTOR(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                float4 _main_var = tex2D(_main,TRANSFORM_TEX(i.uv0, _main));
                clip(_main_var.a - 0.5);
                SHADOW_COLLECTOR_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Cull Off
            Offset 1, 1
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _main; uniform float4 _main_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
/////// Vectors:
                float4 _main_var = tex2D(_main,TRANSFORM_TEX(i.uv0, _main));
                clip(_main_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
