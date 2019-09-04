Shader "Unlit/HoloGram"
{
	Properties
	{
		_MainTex ("Statue Texture", 2D) = "Black" {}
		_TintColor("TinrtColor",Color)=(1,1,1,1)
		_Transparency("Transparency",Range(0,1.0))=.5
		_CutoutTresh("Cut off Threshold",Range(0,1.0))=.5
		_Distance("Distance",float)=1
		_Amplitude("Amp",float)=1
		_speed("Speed",float)=1
		_Amount("Amount",float)=1
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 100
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog 
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _TintColor;
			float _Transparency;
			float _CutoutTresh;
			float _Distance;
			float _Amplitude;
			float _speed;
			float _Amount;
			
			v2f vert (appdata v)
			{
				v2f o;
				v.vertex.x+=sin(_Time.y*_speed+v.vertex.y*_Amplitude)*_Distance*_Amount;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv)+_TintColor;
				col.a=_Transparency;
				clip(col.r-_CutoutTresh);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
