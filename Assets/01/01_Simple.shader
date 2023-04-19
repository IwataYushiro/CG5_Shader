Shader "Unlit/01_Simple"									//�V�F�[�_���/�V�F�[�_��
{
	Properties
	{
		_Color("Color",Color) = (1,0,0,1)					//�Ō�� ; �͕s�v
	}

	SubShader												//���ۂ̃V�F�[�_�A�����p�Ӊ\
	{														//�؂�ւ����ł���
		Pass												//1Pass��1�`��
		{
			CGPROGRAM										//��������HLSL����(ENDCG�ƃZ�b�g)
			#pragma vertex vert								//���_�V�F�[�_�p�֐��� vert
			#pragma fragment flag							//�t���O�����g(�s�N�Z��)�V�F�[�_ flag
			#include "UnityCG.cginc"						//Unity�@�\�ǂݍ���

			fixed4 _Color;									//Properties�ɑΉ������ϐ�

			float4 vert(float4 v:POSITION) : SV_POSITION	//�����Ƃ��ă��[�J�����W���󂯎���
			{
				float4 o;									//float * 4
				o = UnityObjectToClipPos(v);				//���[�J�������[���h���W�֕ϊ����X�N���[�����W��
				return o;
			}

			fixed4 flag(float4 i:SV_POSITION) : SV_TARGET	//��ʕ`��p�Z�}���e�B�N�X
			{												//�l�̐��@fixed < floot
				fixed4 o = _Color;							//�ϐ�Properties�Œl�����߂�_Color����
				return o;
			}
			ENDCG											//�����܂�HLSL����(CGPROGRAM�ƃZ�b�g)
		}
	}
}
