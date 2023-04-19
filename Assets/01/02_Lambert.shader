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
            #include "Lighting.cginc"                           //光源情報

            struct appdata                                      //構造体
            {
                float4 vertex : POSITION;                       //セマンティクスが必要
                float3 normal : NORMAL;                         //法線用セマンティクス
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            fixed4 _Color;

            v2f vert(appdata v)                                 //引数や戻り値の構造体の中にセマンティクスが書かれているので関数部分には不要
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
