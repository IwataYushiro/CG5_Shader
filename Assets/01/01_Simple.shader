Shader "Unlit/01_Simple"									//シェーダ種類/シェーダ名
{
	Properties
	{
		_Color("Color",Color) = (1,0,0,1)					//最後に ; は不要
	}

	SubShader												//実際のシェーダ、複数用意可能
	{														//切り替えもできる
		Pass												//1Passで1描画
		{
			CGPROGRAM										//ここからHLSL言語(ENDCGとセット)
			#pragma vertex vert								//頂点シェーダ用関数名 vert
			#pragma fragment flag							//フラグメント(ピクセル)シェーダ flag
			#include "UnityCG.cginc"						//Unity機能読み込み

			fixed4 _Color;									//Propertiesに対応した変数

			float4 vert(float4 v:POSITION) : SV_POSITION	//引数としてローカル座標を受け取れる
			{
				float4 o;									//float * 4
				o = UnityObjectToClipPos(v);				//ローカル→ワールド座標へ変換→スクリーン座標へ
				return o;
			}

			fixed4 flag(float4 i:SV_POSITION) : SV_TARGET	//画面描画用セマンティクス
			{												//値の数　fixed < floot
				fixed4 o = _Color;							//変数Propertiesで値を決めた_Colorを代入
				return o;
			}
			ENDCG											//ここまでHLSL言語(CGPROGRAMとセット)
		}
	}
}
