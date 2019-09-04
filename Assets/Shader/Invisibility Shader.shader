// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Invisibility"
{
	Properties
	{
		_Blending("Blending", Range( 0 , 1)) = 0
		_Distrotion("Distrotion", 2D) = "bump" {}
		_DistrotionScale("DistrotionScale", Range( 0 , 1)) = 0
		_RippleScale("RippleScale", Range( 0 , 20)) = 0
		_RippleSpeed("RippleSpeed", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _Distrotion;
		uniform float _RippleScale;
		uniform float _RippleSpeed;
		uniform float _DistrotionScale;
		uniform float _Blending;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = float3(0,0,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos7 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale7 = -1.0;
			#else
			float scale7 = 1.0;
			#endif
			float halfPosW7 = ase_screenPos7.w * 0.5;
			ase_screenPos7.y = ( ase_screenPos7.y - halfPosW7 ) * _ProjectionParams.x* scale7 + halfPosW7;
			ase_screenPos7.xyzw /= ase_screenPos7.w;
			float4 screenColor2 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ( float4( ( UnpackNormal( tex2D( _Distrotion, ( _RippleScale * (( ( _Time.y * _RippleSpeed ) + ase_screenPos7 )).xy ) ) ) * _DistrotionScale ) , 0.0 ) + ase_screenPos7 ) ) );
			float4 temp_cast_1 = (1.0).xxxx;
			float4 lerpResult3 = lerp( screenColor2 , temp_cast_1 , _Blending);
			o.Emission = lerpResult3.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14101
134;123;1063;513;87.95395;614.3839;1.475423;True;True
Node;AmplifyShaderEditor.TimeNode;19;-146.6925,-423.7105;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-238.2943,-264.2555;Float;False;Property;_RippleSpeed;RippleSpeed;4;0;Create;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;7;260.7221,-141.6145;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;65.34856,-235.4178;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;216.3218,-264.2556;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT4;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-116.1586,-522.0974;Float;False;Property;_RippleScale;RippleScale;3;0;Create;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;20;60.25959,-337.1977;Float;False;FLOAT2;0;1;0;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;170.5209,-515.3123;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT2;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;344.0298,-296.4857;Float;False;Property;_DistrotionScale;DistrotionScale;2;0;Create;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;317.5141,-502.2401;Float;True;Property;_Distrotion;Distrotion;1;0;Create;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/SmallWaves.png;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;627.9144,-363.3731;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;503.7635,-187.2774;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenColorNode;2;648.5176,-197.97;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;Object;-1;False;1;0;FLOAT4;0,0,0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;673.3682,-4.87822;Float;False;Constant;_White;White;0;0;Create;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;556.0674,104.4204;Float;False;Property;_Blending;Blending;0;0;Create;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;863.2039,23.04665;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;1;843.4175,-161.8553;Float;False;Constant;_Vector0;Vector 0;0;0;Create;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1113.371,-397.1652;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Invisibility;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Translucent;0.5;True;True;0;False;Opaque;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;19;2
WireConnection;25;1;24;0
WireConnection;23;0;25;0
WireConnection;23;1;7;0
WireConnection;20;0;23;0
WireConnection;21;0;22;0
WireConnection;21;1;20;0
WireConnection;6;1;21;0
WireConnection;9;0;6;0
WireConnection;9;1;10;0
WireConnection;8;0;9;0
WireConnection;8;1;7;0
WireConnection;2;0;8;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;3;2;5;0
WireConnection;0;0;1;0
WireConnection;0;2;3;0
ASEEND*/
//CHKSM=FEAFCE14C26C8949775C0769CD37EE7E0296F678