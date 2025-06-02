String? validarCpf(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'CPF não pode estar vazio';
  }
  if (!RegExp(r"^\d{3}\.\d{3}\.\d{3}-\d{2}$").hasMatch(value)) {
    return 'Formato de CPF inválido';
  }
  return null;
}

String? validarSenha(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Senha não pode estar vazia';
  }
  if (value.length < 6) {
    return 'Senha deve ter no mínimo 6 caracteres';
  }
  return null;
}

String? validarUrl(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'URL do campo não pode estar vazia';
  }
  if (!RegExp(r'^(http|https):\/\/.*$').hasMatch(value)) {
    return 'URL do campo precisa estar no formato válido';
  }
  return null;
}

String? validarCampoTexto(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Campo não pode estar vazio';
  }
  if (value.length < 3) {
    return 'Campo deve ter no mínimo 3 caracteres';
  }
  return null;
}

String? validarDataHora(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Data/Hora não pode estar vazia';
  }
  if (!RegExp(r'^\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}$').hasMatch(value)) {
    return 'Formato de data/hora inválido';
  }
  return null;
}