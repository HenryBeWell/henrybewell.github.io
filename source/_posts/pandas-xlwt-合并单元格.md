---
title: pandas+xlwt 合并单元格
date: 2020-06-29 21:31:01
tags:
- python
- pandas
categories:
- python
- package
---
需求：根据某一列的值对指定的其他列做合并操作(根据A列，对BC列作合并单元格)
<!-- more -->

合并前:

![合并前](https://img-blog.csdnimg.cn/20200629161533818.png)

合并后:

![合并后](https://img-blog.csdnimg.cn/20200629162149502.png)

```python
import xlwt
import pandas as pd

class Merge_cell():
    '''
    目标：根据某列值对指定列值进行合并
    '''

    def __init__(self, excel_path, df, key_col, col2):
        self.excel_path = excel_path
        self.df = (df.drop(columns='index') if 'index' in df.columns else df)
        self.key_col = key_col
        self.col2 = col2
        self.wb = xlwt.Workbook(excel_path)
        self.worksheet = self.wb.add_sheet('sheet1')

    def _get_idx(self):
        groups = self.df.groupby(self.key_col)
        idxs = [[groups.get_group(i).index.min() + 1, groups.get_group(i).index.max() + 1] for i in groups.size().index]
        return idxs, len(idxs)

    def _get_content(self, idx, key):
        """

        :param idxs: 索引 [[1,2],[3,4]]
        :return: 暂时保存合并单元的值
        """
        import numpy as np

        if not pd.isna(self.df.at[idx, key]):
            temp = self.df.at[idx, key]
        else:
            temp = None
        return temp

    def merged(self):
        import numpy as np
        if not self.key_col:  # 如果key_cols 参数不传值，则无需合并
            self.df.to_excel(self.excel_path, index=False)
            return
        idxs, length = self._get_idx()
        line_cn = self.df.index.size
        cols = list(self.df.columns.values)
        column_number = {col: idx for idx, col in enumerate(cols)}
        if self.key_col not in cols:  # 校验key_cols中各元素 是否都包含与对象的列
            print("key_cols is not completely include object's columns")
            return False
        if not all([v in cols for i, v in enumerate(self.col2)]):  # 校验merge_cols中各元素 是否都包含与对象的列
            print("merge_cols is not completely include object's columns")
            return False
        for value, i in column_number.items():  # 写表头
            self.worksheet.write(0, i, value)
        for key, idx in column_number.items():
            if key not in self.col2:
                for i in range(line_cn):
                    value = self.df.loc[i, key]
                    if not pd.isna(value):
                        self.worksheet.write(i + 1, idx, str(value))
                    else:
                        pass
            else:
                for j in idxs:
                    value = self._get_content(j[0] - 1, key)
                    if value:
                        self.worksheet.write_merge(j[0], j[1], idx, idx, value)
                    else:
                        pass
        self.wb.save(self.excel_path)
if __name__ == '__main__':
    te = {'A': [1, 2, 2, 2, 3, 3], 'B': [1, 1, 1, 1, 1, 1], 'C': [1, 1, 1, 1, 1, 1], 'D': [1, 1, 1, 1, 1, 1]}
    t_f = pd.DataFrame(te)
    DF = Merge_cell('000_1.xls', t_f, 'A', ['B', 'C'])
    DF.merged()
```

[参考]:https://blog.csdn.net/cakecc2008/article/details/59203980