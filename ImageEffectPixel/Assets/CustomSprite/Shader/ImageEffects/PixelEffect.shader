Shader "CustomImageEffect/PixelEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_PixelSize ("Pixel width", float) = 1.0
    }
    SubShader
    {
		Cull Off 

		ZWrite Off

		ZTest Always

		Stencil {
			Ref 1
			ReadMask 1
			Comp Equal
			Pass Replace
		}

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;

			half _PixelSize;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);

				half2 pixels = _PixelSize * (_ScreenParams.zw - 1);

				half2 pixelUV = half2(pixels * round(i.uv / pixels));

				col = tex2D(_MainTex, pixelUV);

                return col;
            }
            ENDCG
        }
    }
}
