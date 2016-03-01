#!/usr/bin/python3

# this tool will help
# get plot data from
# a gnuplot-produced
# svg file

from sys import stdin, argv
from xml.etree import ElementTree

def unpack_xml(xmlstr):
    root = ElementTree.fromstring(xmlstr)
    g_tag = None
    for g in root.iter('{http://www.w3.org/2000/svg}g'):
        try:
            if g.attrib['id'] == 'gnuplot_plot_1':
                g_tag = g
                break
        except:
            pass
    return g_tag[1][0].attrib['d']


def unpack_dots(s):
    pt_set = set()
    for pt in s.split():
        xy = pt[1:].split(',')
        pt_set.add((min(255,round(float(xy[0]))),
            min(200,round(float(xy[1])))))
    return pt_set


def pack_tables(pt_set):
    return ([p[0] for p in pt_set],[p[1] for p in pt_set])


def fmt_table(table):
    lines = []
    for i in range(0,len(table),8):
        bts = ['$'+hex(x)[2:].zfill(2) for x in table[i:i+8]]
        lines.append('    !byte '+','.join(bts))
    return '\n'.join(lines)


def main():
    if len(argv)<2:
        num = ''
    else:
        num = argv[1]
    pts = pack_tables(unpack_dots(unpack_xml(stdin.read())))
    xtbl = fmt_table(pts[0])
    ytbl = fmt_table(pts[1])
    print('x_table'+num)
    print(xtbl)
    print()
    print('y_table'+num)
    print(ytbl)
    print()


if __name__=='__main__':
    main()
