#version 150 core
#extension GL_ARB_explicit_attrib_location : enable

// �O�p�`�̒��_�ʒu
const vec4 position[] = vec4[](
  vec4(-0.1, -0.0866, 0.0, 0.0),
  vec4( 0.1, -0.0866, 0.0, 0.0),
  vec4( 0.0,  0.0866, 0.0, 0.0)
  );

// ���ʑ̂̒��_�F
const vec4 color[] = vec4[](
  vec4(1.0, 0.0, 0.0, 1.0),
  vec4(0.0, 1.0, 0.0, 1.0),
  vec4(0.0, 0.0, 1.0, 1.0)
  );

// �ϊ��s��
uniform mat4 mv;                                      // ���f���r���[�ϊ��s��
uniform mat4 mp;                                      // ���e�ϊ��s��
uniform mat4 mn;                                      // �@���x�N�g���̕ϊ��s��

// �W�I���g���V�F�[�_�ɓ��͂����}�`�v�f
layout(points) in;

// �W�I���g���V�F�[�_����o�͂���}�`�v�f�ƍő咸�_��
layout(triangle_strip, max_vertices = 12) out;

// ���X�^���C�U�ɑ��钸�_����
out vec4 iamb;                                        // �����̔��ˌ����x
out vec4 idiff;                                       // �g�U���ˌ����x
out vec4 ispec;                                       // ���ʔ��ˌ����x

void main()
{
  mat4 mc = mp * mv;

  for (int i = 0; i < 3; ++i)
  {
    gl_Position = mc * vec4(gl_in[0].gl_Position + position[i]);

    iamb = vec4(0.0);
    idiff = color[i];
    ispec = vec4(0.0);

    EmitVertex();
  }

  EndPrimitive();
}
