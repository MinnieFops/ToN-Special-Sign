Shader "Toocanzs/Vertical Billboard/Transparent"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _Color ("Text Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _BackColor ("Background Color", Color) = (1.0, 1.0, 1.0, 0.1)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}
        LOD 100
		
		Blend SrcAlpha OneMinusSrcAlpha
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
            float4 _Color;
            float4 _BackColor;
			
            SamplerState sampler_PointClamp;
			
			#include "UnityCG.cginc"

			#include "VerticalBillboard.cginc"

			uniform float _VRChatMirrorMode;
			

			bool isMirror() { return _VRChatMirrorMode != 0; }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = _MainTex.Sample(sampler_PointClamp, i.uv);
                col = lerp(_BackColor, _Color, col.a);
                //col = lerp(col, _BackColor, i.backFactor)
                if (isMirror()){
					col = fixed4(0,0,0,0);
				}
                return col;

            }
	

			ENDCG
		}
	}
}