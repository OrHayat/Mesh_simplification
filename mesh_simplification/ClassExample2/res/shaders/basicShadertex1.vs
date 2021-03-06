// Vertex shader for a point-light (local) source, with computation
// done in the fragment shader.
#version 130

//uniform vec3 LightPosition;
uniform vec4 eyeDirection;
uniform float Shininess;
//uniform vec3 AmbientContribution ;
//uniform vec3 DiffuseContribution ;
uniform vec3 SpecularContribution ;

out vec3 LightIntensity;
//out vec2 texCoord;

void main()
{
	vec3 ecPosition = vec3(gl_ModelViewMatrix * eyeDirection);
	vec3 tnorm =  - normalize(gl_NormalMatrix * gl_Normal);
	vec3 lightVec = normalize(vec3(gl_LightSource[0].position) - ecPosition);
	vec3 reflectVec = reflect(-lightVec, tnorm);
	vec3 viewVec = normalize(-ecPosition);
	float diffuse = max(dot(lightVec, tnorm), 0.0);
	float spec = 0.0;
	
	if (diffuse > 0.0)
	{
	spec = max(dot(reflectVec, viewVec), 0.0);
	spec = pow(spec, Shininess);
	}
	//LightIntensity = vec3(gl_LightSource[0].ambient) * vec3(gl_Color) + vec3(gl_Color)  * vec3(gl_LightSource[0].diffuse) * diffuse + SpecularContribution * vec3(gl_LightSource[0].specular) * spec;
	LightIntensity = abs(normalize(gl_Normal));
	gl_FrontColor = gl_Color ;
	gl_Position = ftransform();
	gl_TexCoord[0] = gl_MultiTexCoord0;


}
