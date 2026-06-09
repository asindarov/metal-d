/**
    MTLRenderPipeline

    Copyright: Copyright © 2024-2025, Kitsunebi Games EMV
    License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
    Authors:   Asadbek Sindarov 
*/


module metal.computepipeline;
import metal.library;
import metal.renderpass;
import metal.types;
import metal.device;
import metal.argument;
import foundation;
import metal.buffer;
import metal.commandencoder;
import objc;
import core.attribute : selector, optional;

extern (Objective-C)
extern interface MTLComputeCommandEncoder : MTLCommandEncoder {
  /**
    Configures the compute encoder with a pipeline state for subsequent kernel calls.
  */
  void setComputePipelineState(MTLComputePipelineState state) @selector("setComputePipelineState:");

  /**
    Binds a buffer to the buffer argument table, allowing compute kernels to access its data on the GPU.
  */ 
    void setBuffer(MTLBuffer buffer, NSUInteger offset, NSUInteger index) @selector("setBuffer:offset:atIndex:");


  /**
    Encodes a compute command using an arbitrarily sized grid.
  */
  void dispatchThreads(MTLSize threadsPerGrid, MTLSize threadsPerThreadgroup) @selector("dispatchThreads:threadsPerThreadgroup:");

  /**
    Encodes a compute dispatch command using a grid aligned to threadgroup boundaries.
  */
  void dispatchThreadgroups(MTLSize threadgroupsPerGrid, MTLSize threadsPerThreadgroup) @selector("dispatchThreadgroups:threadsPerThreadgroup:");

  /**
    Declares that all command generation from the encoder is completed.
  */
  void endEncoding() @selector("endEncoding");
}


/**
  Information about the arguments of a compute function.
*/
extern (Objective-C)
extern interface MTLComputePipelineReflection : NSObjectProtocol {
@nogc nothrow
public:
  @property NSArray!MTLBinding bindings() @selector("bindings");
}

/**
  A convenience type alias for an autoreleased compute pipeline reflection object.
*/
alias MTLAutoreleasedComputePipelineReflection = MTLComputePipelineReflection;

/**
  An interface that represents a GPU pipeline configuration for running kernels in a compute pass.
*/
extern (Objective-C)
extern interface MTLComputePipelineState : NSObjectProtocol {
@nogc nothrow
public:
    /**
        The GPU device that created the command queue.
    */
    @property MTLDevice device() const;

    /**
        An optional name that can help you identify the command queue.
    */
    @property NSString label();
    @property void label(NSString);

    /**
        An unique identifier that represents the pipeline state, 
        which you can add to an argument buffer.
    */
    @property MTLResourceID gpuResourceID() const;

    /**
        The largest number of threads the pipeline state can have 
        in a single object shader threadgroup.
    */
    @property NSUInteger maxTotalThreadsPerThreadgroup() const;

    /**
        The number of threads the render pass applies to a SIMD group 
        for an object shader.
    */
    @property NSUInteger threadExecutionWidth() const;

    /**
      The length, in bytes, of statically allocated threadgroup memory.
    */
    @property NSUInteger staticThreadgroupMemoryLength() const;

      /**
        Returns the length of an imageblock’s memory for the specified
        imageblock dimensions.
    */
    @property NSUInteger imageblockMemoryLengthForDimensions(MTLSize imageblockDimensions) @selector(
        "imageblockMemoryLengthForDimensions:") ;

    /**
      A Boolean value that indicates whether the compute pipeline supports indirect command buffers.
    */
   @property bool supportIndirectCommandBuffers() const; 

   /**
        The current state of shader validation for the pipeline.
    */
    @property MTLShaderValidation shaderValidation() const;
}

