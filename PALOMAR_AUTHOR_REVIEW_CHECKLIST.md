# Palomar Registry 作者复核清单

本清单用于在提交 *Feige's 1/e Conjecture in Lean* 至 Palomar Registry 前，
由形式化作者 Guanyang Wang 和 Peng Zhang 人工核对注册声明、论文对应关系、
元数据与公开署名。

人工复核的重点不是逐行重新检查全部 Lean 证明，而是确认注册所宣称的数学内容、
来源、范围和作者信息准确。Lean 构建、Comparator 和 NanoDa 的机械检查不能替代
这项人工核对。

建议两位作者各自独立完成本清单。只有在两位作者都确认后，才应把
`formalization.yaml` 中的 `review.status` 从 `unchecked` 改为
`author-verified`。

## 1. 核对注册定理

打开 [`Challenge.lean`](Challenge.lean)，并对照主论文
*Sharp Small-Deviation Inequalities for Sums of Independent Nonnegative
Random Variables* 的 Theorem 1.1 在 `delta = 1` 时的特例以及对应的
sharpness 结论。

- [x] 定理假设 `n > 0`。
- [x] 定理包含 `n` 个随机变量，索引类型为 `Fin n`。
- [x] 随机变量相互独立。
- [x] 每个随机变量非负、可测且可积。
- [x] 每个随机变量的期望满足 `E[X_i] <= 1`。
- [x] 概率事件使用严格不等式
      `sum X_i < E[sum X_i] + 1`。
- [x] 概率下界为 `(n / (n + 1))^n`。
- [x] 定理不仅证明该下界成立，还证明它是固定维数 `n` 下的最优常数。
- [x] `FixedDimensionalFeigeLowerBound` 准确表达“对所有满足假设的概率空间和
      随机变量族都成立的统一下界”。
- [x] `IsOptimalFixedDimensionalFeigeBound` 准确表达“该常数本身是有效下界，
      且任何其他有效下界都不超过它”。
- [x] 样本空间限制为 `Omega : Type` 是可接受的，并已在元数据中披露。
- [x] 本条目只注册 `delta = 1`，没有暗示已经形式化主论文中全部
      `delta > 0` 的结论。

复核备注：

<!-- 在这里记录任何疑问、修订建议或与论文措辞的差异。 -->

## 2. 核对证明桥接

打开 [`Solution.lean`](Solution.lean)，检查 Palomar 注册声明与主体证明之间的
桥接。

- [x] 最终调用的是预期的
      `Feige.sharp_unit_slack_feige_complete`。
- [x] `PalomarFeige.sharpConstant` 与 `Feige.sharpConstant` 表达相同常数。
- [x] Challenge 和 Solution 中出现的具体定义具有相同含义。
- [x] 桥接没有增加额外假设。
- [x] 桥接没有削弱结论。
- [x] 桥接没有改变严格概率事件或最优性含义。

Comparator 会机械检查 Challenge 与 Solution 的注册声明是否一致；本节的人工
核对是为了确认它们与主论文及主体 Lean 定理具有预期的数学含义。

复核备注：

<!-- 在这里记录任何疑问或修订建议。 -->

## 3. 核对注册元数据

逐段阅读 [`formalization.yaml`](formalization.yaml)。

### 3.1 项目与责任人

- [x] `project.name` 和 `project.description` 准确描述本项目。
- [x] 公开项目名称统一为 *Feige's 1/e Conjecture in Lean*。
- [x] 项目描述明确说明 Lean 结果证明了更强的有限维最优常数
      `(n / (n + 1))^n`，而不只是较弱的统一 `1/e` 下界。
- [x] 形式化作者为 Guanyang Wang 和 Peng Zhang。
- [x] 责任维护者为 Guanyang Wang 和 Peng Zhang。
- [x] 软件许可证 `Apache-2.0` 准确。

### 3.2 文献来源

- [x] 每项来源的标题和作者名单准确。
- [x] arXiv 编号和 DOI 准确。
- [x] 主论文的位置说明准确指向 Theorem 1.1 和 sharpness 部分。
- [x] `formalizes` 与 `background` 的分类准确。
- [x] Vlassis--Thomas 定理的对应关系及表述差异说明准确。
- [x] Grünbaum 定理的对应关系及形式化范围说明准确。
- [x] Nie--Wei、Stander 和 Ling 的工作被准确标记为相关背景，且没有暗示本项目
      使用了它们的证明。

### 3.3 形式化范围与差异

- [x] `status.scope` 没有夸大已经形式化的范围。
- [x] `status.scope` 准确说明了 `n > 0`、`Omega : Type`、`delta = 1`、
      严格事件以及固定维数最优性。
- [x] 未形式化的内容列举准确。
- [x] `fidelity.divergences` 对主论文、Vlassis--Thomas 重构和 Grünbaum
      形式化的差异描述准确。
- [x] `alignment` 中三个来源结果与 Lean 声明的对应关系准确。

### 3.4 自动化披露

- [x] 自动化框架准确记录为 Codex。
- [x] 实际使用的模型准确记录为 `gpt-5.6-sol`。
- [x] reasoning effort 准确记录为 `ultra`。
- [x] AI 自动化没有被列为形式化作者。
- [x] 自动化说明没有把机械验证表述成人工数学复核。

复核备注：

<!-- 在这里记录任何元数据修订建议。 -->

## 4. 核对公开署名和项目说明

检查以下文件：

- [`README.md`](README.md)
- [`CITATION.cff`](CITATION.cff)
- [`NOTICE.md`](NOTICE.md)

确认：

- [x] README 中的数学结论、论文来源和形式化范围准确。
- [x] README 对 Palomar Challenge/Solution 结构的说明准确。
- [x] README 没有声称已经完成 Palomar 注册。
- [x] README 中相关工作的介绍和“不被本项目使用”的说明准确。
- [x] `CITATION.cff` 中的软件作者为 Guanyang Wang 和 Peng Zhang。
- [x] `NOTICE.md` 中的版权归属准确。
- [x] 第三方代码和既有数学结果的归属说明准确。
- [x] AI 仅在 automation/provenance 中披露，没有被列为作者。

复核备注：

<!-- 在这里记录任何公开说明或署名修订建议。 -->

## 5. 两位作者分别确认

### Guanyang Wang

- [x] 我已核对 `Challenge.lean` 中的注册定理及其与主论文的对应关系。
- [x] 我已核对 `Solution.lean` 中的证明桥接。
- [x] 我已核对 `formalization.yaml` 的来源、范围、差异和自动化披露。
- [x] 我已核对 README、CITATION 和 NOTICE 中的公开说明与署名。
- [x] 我确认上述内容准确，或所有发现的问题均已修正。

姓名：Guanyang Wang

日期：2026-08-29

备注：

### Peng Zhang

- [x] 我已核对 `Challenge.lean` 中的注册定理及其与主论文的对应关系。
- [x] 我已核对 `Solution.lean` 中的证明桥接。
- [x] 我已核对 `formalization.yaml` 的来源、范围、差异和自动化披露。
- [x] 我已核对 README、CITATION 和 NOTICE 中的公开说明与署名。
- [x] 我确认上述内容准确，或所有发现的问题均已修正。

姓名：Peng Zhang

日期：2026-08-29

备注：

## 6. 完成复核后的仓库更新

只有在两位作者都完成并确认以上核对后，才执行以下工作：

- [x] 将 `formalization.yaml` 中的 `review.status` 改为
      `author-verified`。
- [x] 将 Guanyang Wang 和 Peng Zhang 加入 `review.reviewers`。
- [x] 在 `review.notes` 中如实记录核对范围和日期。
- [x] 重新验证 `formalization.yaml` schema。
- [x] 重新运行全量 `lake build`。
- [x] 重新运行 Comparator、NanoDa 和公理审计。
- [x] 检查 Git diff，确认没有提交 `Feige.pdf`、
      `feige_palomar_registration_work.md`、构建产物或缓存。
- [ ] 创建 commit 并推送 `palomar-registration` 分支。
- [ ] 等待 Linux GitHub Actions 全部通过。
- [ ] 使用通过验证的完整 40 字符 commit SHA 提交 Palomar Registry。

## 最终签署说明

本清单中的勾选和签名表示作者已核对注册内容与来源的一致性。它属于作者复核，
不应被描述为外部同行评审或 Palomar Registry 的正式接受。
