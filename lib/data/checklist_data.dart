import 'models.dart';

final List<Grupo> grupos = [
  Grupo(
    nome: 'Grupo 1 - Documentação',
    itens: [
      ChecklistItem(nome: 'CNH Válida', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'CRLV Atualizado', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Seguro Obrigatório', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 2 - Equipamentos de Emergência',
    itens: [
      ChecklistItem(nome: 'Extintor', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Kit de Derramamento', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Cone de Sinalização', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 3 - Pneus',
    itens: [
      ChecklistItem(nome: 'Pneus dianteiros', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Pneus traseiros', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Estepe', prazoBloqueio: '7 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 4 - Iluminação',
    itens: [
      ChecklistItem(nome: 'Faróis', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Lanternas', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Setas', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 5 - Estrutura do Veículo',
    itens: [
      ChecklistItem(nome: 'Para-choque', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Retrovisores', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Parafusos e suportes', prazoBloqueio: '7 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 6 - Vazamentos',
    itens: [
      ChecklistItem(nome: 'Tanque combustível', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Óleo motor', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Freios', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 7 - Sistemas de Freios',
    itens: [
      ChecklistItem(nome: 'Freio motor', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Freio de serviço', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Freio de estacionamento', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 8 - Direção e Suspensão',
    itens: [
      ChecklistItem(nome: 'Folgas na direção', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Amortecedores', prazoBloqueio: '3 dias'),
      ChecklistItem(nome: 'Molas e buchas', prazoBloqueio: '7 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 9 - Sinalização e Comunicação',
    itens: [
      ChecklistItem(nome: 'Buzina', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Alarme de ré', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Adesivos de risco', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 10 - Cabine',
    itens: [
      ChecklistItem(nome: 'Cinto de segurança', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Banco fixo e travado', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Painel funcionando', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 11 - Motor e Sistema Elétrico',
    itens: [
      ChecklistItem(nome: 'Nível de óleo', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Correias em bom estado', prazoBloqueio: '3 dias'),
      ChecklistItem(nome: 'Bateria', prazoBloqueio: '7 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 12 - Tanque e Compartimentos',
    itens: [
      ChecklistItem(nome: 'Travas e lacres', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Tampas', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Proteções', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 13 - Acessórios Obrigatórios',
    itens: [
      ChecklistItem(nome: 'Calços de rodas', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Macaco hidráulico', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'Chave de rodas', prazoBloqueio: '3 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 14 - Meio Ambiente',
    itens: [
      ChecklistItem(nome: 'Sem resíduos no chassi', prazoBloqueio: '3 dias'),
      ChecklistItem(nome: 'Sem vazamentos visíveis', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Documentação ambiental', prazoBloqueio: '7 dias'),
    ],
  ),
  Grupo(
    nome: 'Grupo 15 - Segurança Operacional',
    itens: [
      ChecklistItem(nome: 'Equipamento correto', prazoBloqueio: 'Imediato'),
      ChecklistItem(nome: 'Uniforme completo', prazoBloqueio: '1 dia'),
      ChecklistItem(nome: 'EPI em uso', prazoBloqueio: 'Imediato'),
    ],
  ),
];
