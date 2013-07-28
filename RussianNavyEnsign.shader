Shader "Custom/water" {
	Properties {
	}
	SubShader {
		Pass {

			GLSLPROGRAM
 
			#include "UnityCG.glslinc"

			#ifdef VERTEX 
			varying vec4 p;
			varying vec2 _vtexCoord;

			void main() {  
				_vtexCoord = gl_MultiTexCoord0.xy;
				vec4 _pos = gl_Vertex;
	
				_pos.y += sin(_Time.w + (_pos.z + _pos.x) * 0.4)/4.0;
	
				p = _pos;
				gl_Position =  gl_ModelViewProjectionMatrix * _pos;
			}
			#endif

			#ifdef FRAGMENT
			varying vec4 p;
			varying vec2 _vtexCoord;
			
			void main()
				{
				
				float height = sin(_Time.y + (p.z+p.x))/2.0;
				vec4 _color = vec4 (1.0-height,1.0-height,1.0-height,1.0);
				
				if ( ((_vtexCoord.y < (_vtexCoord.x + 0.1)) && (_vtexCoord.y > (_vtexCoord.x - 0.1))) || ((_vtexCoord.y < (1.1 - _vtexCoord.x)) && (_vtexCoord.y > (0.9 - _vtexCoord.x))) )
				_color = vec4 (0.0,0.0,1.0-height,1.0);
				
				gl_FragColor = _color;
			}
			#endif
			
			ENDGLSL
		}
	}  
}
