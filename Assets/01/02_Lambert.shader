Shader "Unlit/02_Lambert"
{
    Properties
    {
        _Color("BaseColor",Color) = (1,1,1,1)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"                           //�������

            struct appdata                                      //�\����
            {
                float4 vertex : POSITION;                       //�Z�}���e�B�N�X���K�v
                float3 normal : NORMAL;                         //�@���p�Z�}���e�B�N�X
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            fixed4 _Color;

            v2f vert(appdata v)                                 //������߂�l�̍\���̂̒��ɃZ�}���e�B�N�X��������Ă���̂Ŋ֐������ɂ͕s�v
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float intensity = (dot(normalize(i.normal),_WorldSpaceLightPos0));
                
                fixed4 color = _Color;
                fixed4 diffuse = color * intensity * _LightColor0;

                return diffuse;
            }
            ENDCG
        }
    }
}
