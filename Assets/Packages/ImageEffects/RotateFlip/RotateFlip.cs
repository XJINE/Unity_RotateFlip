using UnityEngine;

[ExecuteAlways]
[RequireComponent(typeof(Camera))]
public class RotateFlip : ImageEffectBase
{
    #region Field

    public bool flipX   = false;
    public bool flipY   = false;
    public bool rotateL = false;
    public bool rotateR = false;

    protected static int FlipXPropId   = 0;
    protected static int FlipYPropId   = 0;
    protected static int RotateLPropId = 0;
    protected static int RotateRPropId = 0;

    #endregion Field

    #region Method

    static RotateFlip()
    {
        FlipXPropId   = Shader.PropertyToID("_FlipX");
        FlipYPropId   = Shader.PropertyToID("_FlipY");
        RotateLPropId = Shader.PropertyToID("_RotateL");
        RotateRPropId = Shader.PropertyToID("_RotateR");
    }

    protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        base.material.SetInt(FlipXPropId,   this.flipX   ? 1 : 0);
        base.material.SetInt(FlipYPropId,   this.flipY   ? 1 : 0);
        base.material.SetInt(RotateLPropId, this.rotateL ? 1 : 0);
        base.material.SetInt(RotateRPropId, this.rotateR ? 1 : 0);

        base.OnRenderImage(source, destination);
    }

    #endregion Method
}