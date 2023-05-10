Shader "Unlit/31_Test1"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_AmbientColor("Ambient",Color) = (0.3,0,0,1)
		_AmbientBright("Bright",Range(0,1.0)) = 0.2
		_DiffuseColor("Diffuse",Color) = (0.3,0,0,1)
	}
		SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
				float3 worldPosition : TEXCOORD1;   //ワールド座標用に変数追加
				float2 uv : TEXCOORD0;
			};

			fixed4 _AmbientColor;
			float  _AmbientBright;
			fixed4 _DiffuseColor;
			sampler2D _MainTex;
			float4    _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 ambient = _AmbientColor * _AmbientBright;

				float intensity = smoothstep(0.3,0.35, saturate(dot(normalize(i.normal), _WorldSpaceLightPos0)));
				fixed4 diffuseColor = _DiffuseColor;
				fixed4 diffuse = diffuseColor * intensity * _LightColor0;

				float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);
				float3 lightDir = normalize(_WorldSpaceLightPos0);
				i.normal = normalize(i.normal);
				float3 reflectDir = -lightDir + 2 * i.normal * dot(i.normal, lightDir);
				fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

				fixed4 ads = ambient + diffuse + specular;
			
				float2 tiling = _MainTex_ST.xy;
				float2 offset = _MainTex_ST.zw;
				fixed4 col = tex2D(_MainTex, i.uv * tiling + offset);

				return ads + col;
			}
			ENDCG
		}
	}
}

