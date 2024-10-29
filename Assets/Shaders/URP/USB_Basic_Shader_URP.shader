Shader "Custom/USB_Basic_Shader_URP"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 0, 0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"=="Transparent" "RenderPipeline"="UniversalRenderPipeline"}
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Package/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

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

            v2f vert (appdata v)
            {
                v2f o;
                //o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertex = TransformObjectToHClip(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                return col * float4(1, 0, 0, 1);
            }
            ENDHLSL
        }
    }
}
