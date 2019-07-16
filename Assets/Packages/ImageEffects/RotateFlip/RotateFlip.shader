Shader "Hidden/RotateFlip"
{
    Properties
    {
        [HideInInspector]
        _MainTex ("Texture", 2D) = "white" {}

        [Toggle] _RotateL ("Rotate L", Int) = 0
        [Toggle] _RotateR ("Rotate R", Int) = 0
        [Toggle] _FlipX   ("Flip X",   Int) = 0
        [Toggle] _FlipY   ("Flip Y",   Int) = 0
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma  vertex   vert
            #pragma  fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv     : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv     : TEXCOORD0;
            };

            sampler2D _MainTex;

            int _RotateL;
            int _RotateR;
            int _FlipX;
            int _FlipY;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = _RotateR ?
                       v.uv.x == 0 ? 
                       v.uv.y == 0 ? float2(1, 0) : float2(0, 0) :
                       v.uv.y == 0 ? float2(1, 1) : float2(0, 1) :
                       _RotateL ? 
                       v.uv.x == 0 ?
                       v.uv.y == 0 ? float2(0, 1) : float2(1, 1) :
                       v.uv.y == 0 ? float2(0, 0) : float2(1, 0) : v.uv;
                o.uv = _FlipX ? 
                       float2(1 - o.uv.x, o.uv.y) : o.uv;
                o.uv = _FlipY ?
                       float2(o.uv.x, 1 - o.uv.y) : o.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.uv);
            }

            ENDCG
        }
    }
}