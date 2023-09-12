Shader "Custom/USB_Culling_Shader"
{
    Properties
    {
        _FrontTex ("Front Texture", 2D) = "white" {}
        _BackTex ("Back Texture", 2D) = "white" {}

        [Enum(UnityEngine.Rendering.CullMode)]
        _Cull ("Cull Mode", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Cull [_Cull]
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _FrontTex;
            float4 _FrontTex_ST;
            sampler2D _BackTex;
            float4 _BackTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _FrontTex);
                o.uv2 = TRANSFORM_TEX(v.uv2, _BackTex);
                return o;
            }

            fixed4 frag (v2f i, bool face : SV_IsFrontFace) : SV_Target
            {
                fixed4 front = tex2D(_FrontTex, i.uv);
                fixed4 back = tex2D(_BackTex, i.uv2);
                return face ? front : back;
            }
            ENDCG
        }
    }
}
