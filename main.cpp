// �E�B���h�E�֘A�̏���
#include "Window.h"

// �W�����C�u����
#include <cmath>
#include <memory>

// ����
const GgSimpleShader::Light light =
{
  { 0.2f, 0.2f, 0.2f, 1.0f },
  { 1.0f, 1.0f, 1.0f, 1.0f },
  { 1.0f, 1.0f, 1.0f, 1.0f },
  { 3.0f, 4.0f, 5.0f, 1.0f }
};

// �I�u�W�F�N�g�̍ގ�
const GgSimpleShader::Material material =
{
  { 0.7f, 0.5f, 0.5f, 1.0f },
  { 0.7f, 0.5f, 0.5f, 1.0f },
  { 0.2f, 0.2f, 0.2f, 1.0f },
  50.0f
};

//
// ���C���v���O����
//
int main(int argc, const char *argv[])
{
  // �E�B���h�E���쐬����
  Window window("ggsample14");

  // �w�i�F���w�肷��
  glClearColor(0.2f, 0.4f, 0.6f, 0.0f);

  // �B�ʏ�����L���ɂ���
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);

  // �}�`�p�̃v���O�����I�u�W�F�N�g
  GgSimpleShader simple("simple.vert", "simple.frag");

  // �_�Q�̃V�F�[�_
  GgPointShader point("point.vert", "point.frag", "point.geom");

  // OBJ �t�@�C���̓ǂݍ���
  const std::unique_ptr<const GgElements> object(ggElementsObj("bunny.obj"));

  // �_
  const std::unique_ptr<const GgPoints> sphere(ggPointsSphere(100, 1.0f, 0.0f, 0.0f, 0.0f));

  // �r���[�ϊ��s��� mv �ɋ��߂�
  const GgMatrix mv(ggLookat(0.0f, 0.0f, 3.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f));

  // �E�B���h�E���J���Ă���Ԃ���Ԃ��`�悷��
  while (window.shouldClose() == GL_FALSE)
  {
    // ���e�ϊ��s��
    const GgMatrix mp(ggPerspective(0.5f, window.getAspect(), 1.0f, 15.0f));

    // ��ʏ���
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // �}�`�̕`��
    simple.use();
    simple.loadLightMaterial(light);
    simple.loadLightPosition(light.position);
    simple.loadMaterial(material);
    simple.loadMatrix(mp, mv);
    object->draw();

    // �_�Q�̕`��
    point.use();
    point.loadMatrix(mp, mv * window.getLeftTrackball());
    sphere->draw();

    // �J���[�o�b�t�@�����ւ��ăC�x���g�����o��
    window.swapBuffers();
  }

  return 0;
}
