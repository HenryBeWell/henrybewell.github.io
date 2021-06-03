---
title: python-pandas-apply
date: 2019-03-07 21:02:31
tags:
- python
- pandas
categories:
- python
- package
---
Pandas多列复杂运算——apply
<!-- more -->


```python
import pandas as pd
import numpy as np
df = pd.DataFrame ({'a' : np.random.randn(6),
                 'b' : ['foo', 'bar'] * 3,
                 'c' : np.random.randn(6)})
df
```

```python
out：
	a		b		c
0	-0.683575	foo	-0.763427
1	2.306715	bar	-0.678599
2	-0.928121	foo	-1.387048
3	-0.541790	bar	0.144686
4	0.015991	foo	1.407063
5	0.651941	bar	0.802702
```

```python
def add(row):
    return row['a'] + 2 * row['c']
df['d'] = df.apply(add, axis=1)
# df['d'] = df.apply(lambda x: x['a'] + 2 * x['c'], axis=1)
df
```

```python
out:
	a	 	b		c		d
0	-0.683575	foo	-0.763427	-2.210428
1	2.306715	bar	-0.678599	0.949516
2	-0.928121	foo	-1.387048	-3.702218
3	-0.541790	bar	0.144686	-0.252418
4	0.015991	foo	1.407063	2.830117
5	0.651941	bar	0.802702	2.257346
```

