# Business Dictionary

> `business-dictionary.yml` is the structured source of truth. This file is the human-readable view.

## Business Domains

- **组织与成员**：工作区、成员、邀请和加入过程。
- **计费治理**：计费账户、席位容量与占用资格。

## Core Terms

| ID | 中文名称 | 定义 | 状态 |
|---|---|---|---|
| `workspace` | 工作区 | 成员协作与席位容量共同生效的业务边界 | confirmed |
| `member` | 成员 | 已加入工作区的参与者身份 | confirmed |
| `invitation` | 邀请 | 尚未完成成员建立的加入过程 | confirmed |
| `billing_account` | 计费账户 | 承担席位容量与计费责任 | confirmed |
| `seat` | 席位 | 可被预留、占用和释放的计费资格单位 | provisional |

## Language Boundary

- 使用“成员占用席位”，不要说“成员就是席位”；
- 使用“席位容量 / 席位对象”，不要把业务语义写成数据字段；
- Seat 的独立对象身份等待 `BMD-001`。
