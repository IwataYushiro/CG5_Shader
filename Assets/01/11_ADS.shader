Shader "Unlit/11_ADS"
{
	Properties
	{
		_AmbientColor("Ambient",Color) = (0.3,0,0,1)
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
				float3 worldPosition : TEXCOORD1;   //ワールド座標用に変数追加
			};

			fixed4 _AmbientColor;
			fixed4 _DiffuseColor;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 ambient = _AmbientColor;

				float intensity = (dot(normalize(i.normal), _WorldSpaceLightPos0));
				fixed4 diffuseColor = _DiffuseColor;
				fixed4 diffuse = diffuseColor * intensity * _LightColor0;

				float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);
			    float3 lightDir = normalize(_WorldSpaceLightPos0);
			    i.normal = normalize(i.normal);
			    float3 reflectDir = -lightDir + 2 * i.normal * dot(i.normal, lightDir);
			    fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

				fixed4 ads = ambient + diffuse + specular;
				return ads;
			}
			ENDCG
		}
	}
}
