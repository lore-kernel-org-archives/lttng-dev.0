From: Amit Margalit <AMITM@il.ibm.com>
Subject: Getting SIGBUS in babeltrace - occasionally
Date: Wed, 24 Jul 2013 12:09:21 +0300
Message-ID: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2__41598.6107466326$1374657039$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0216067888=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V1v4n-0002pf-T1
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 05:09:48 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 24 Jul 2013 10:01:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C953E17D8059
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 10:11:11 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6O99Jeb62783528
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 09:09:19 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6O99UoN000305
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 03:09:30 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r6O99UR5032765
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 03:09:30 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0216067888==
Content-Type: multipart/alternative; boundary="=_alternative 00323AD3C2257BB2_="

This is a multipart message in MIME format.
--=_alternative 00323AD3C2257BB2_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I am getting occasional SIGBUS inside _aligned_integer_read() in 
./formats/ctf/types/integer.c

Here is the backtrace, maybe someone could take a look and suggest 
something:
#0  _aligned_integer_read (definition=0x954320, ppos=0x106e028) at 
integer.c:81
#1  ctf_integer_read (ppos=0x106e028, definition=0x954320) at 
integer.c:224
#2  0x00007ffff070e36e in generic_rw (definition=<optimized out>, 
pos=0x106e028) at ../include/babeltrace/types.h:133
#3  bt_struct_rw (ppos=0x106e028, definition=0x9542e0) at struct.c:56
#4  0x00007ffff13f7fda in generic_rw (definition=<optimized out>, 
pos=0x106e028) at ../../include/babeltrace/types.h:133
#5  ctf_packet_seek (stream_pos=0x106e028, index=<optimized out>, 
whence=<optimized out>) at ctf.c:860
#6  0x00007ffff070a3f1 in seek_file_stream_by_timestamp 
(cfs=cfs@entry=0x106cf90, timestamp=timestamp@entry=1374636821498972926) 
at iterator.c:141
#7  0x00007ffff070aa96 in seek_ctf_trace_by_timestamp 
(stream_heap=0x176d310, timestamp=1374636821498972926, tin=<optimized 
out>) at iterator.c:188
#8  bt_iter_set_pos (iter=iter@entry=0xfdafa0, iter_pos=0x2bf59f0) at 
iterator.c:439
#9  0x00007ffff1624f01 in _wrap__bt_iter_set_pos (self=<optimized out>, 
args=<optimized out>) at babeltrace_wrap.c:3805
#10 0x00007ffff7b28c0c in call_function (oparg=<optimized out>, 
pp_stack=<optimized out>) at Python/ceval.c:3679
#11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=<optimized out>) at 
Python/ceval.c:2370
#12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0, 
globals=<optimized out>, locals=<optimized out>, args=0x2088cc8, 
argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)
    at Python/ceval.c:2942
.
.
.

Any suggestions are welcome.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 00323AD3C2257BB2_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I am getting occasional SIGBUS inside
_aligned_integer_read() in ./formats/ctf/types/integer.c</font>
<br>
<br><font size=2 face="sans-serif">Here is the backtrace, maybe someone
could take a look and suggest something:</font>
<br><font size=2 face="sans-serif">#0 &nbsp;_aligned_integer_read (definition=0x954320,
ppos=0x106e028) at integer.c:81</font>
<br><font size=2 face="sans-serif">#1 &nbsp;ctf_integer_read (ppos=0x106e028,
definition=0x954320) at integer.c:224</font>
<br><font size=2 face="sans-serif">#2 &nbsp;0x00007ffff070e36e in generic_rw
(definition=&lt;optimized out&gt;, pos=0x106e028) at ../include/babeltrace/types.h:133</font>
<br><font size=2 face="sans-serif">#3 &nbsp;bt_struct_rw (ppos=0x106e028,
definition=0x9542e0) at struct.c:56</font>
<br><font size=2 face="sans-serif">#4 &nbsp;0x00007ffff13f7fda in generic_rw
(definition=&lt;optimized out&gt;, pos=0x106e028) at ../../include/babeltrace/types.h:133</font>
<br><font size=2 face="sans-serif">#5 &nbsp;ctf_packet_seek (stream_pos=0x106e028,
index=&lt;optimized out&gt;, whence=&lt;optimized out&gt;) at ctf.c:860</font>
<br><font size=2 face="sans-serif">#6 &nbsp;0x00007ffff070a3f1 in seek_file_stream_by_timestamp
(cfs=cfs@entry=0x106cf90, timestamp=timestamp@entry=1374636821498972926)
at iterator.c:141</font>
<br><font size=2 face="sans-serif">#7 &nbsp;0x00007ffff070aa96 in seek_ctf_trace_by_timestamp
(stream_heap=0x176d310, timestamp=1374636821498972926, tin=&lt;optimized
out&gt;) at iterator.c:188</font>
<br><font size=2 face="sans-serif">#8 &nbsp;bt_iter_set_pos (iter=iter@entry=0xfdafa0,
iter_pos=0x2bf59f0) at iterator.c:439</font>
<br><font size=2 face="sans-serif">#9 &nbsp;0x00007ffff1624f01 in _wrap__bt_iter_set_pos
(self=&lt;optimized out&gt;, args=&lt;optimized out&gt;) at babeltrace_wrap.c:3805</font>
<br><font size=2 face="sans-serif">#10 0x00007ffff7b28c0c in call_function
(oparg=&lt;optimized out&gt;, pp_stack=&lt;optimized out&gt;) at Python/ceval.c:3679</font>
<br><font size=2 face="sans-serif">#11 PyEval_EvalFrameEx (f=0x1c243c0,
throwflag=&lt;optimized out&gt;) at Python/ceval.c:2370</font>
<br><font size=2 face="sans-serif">#12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx
(co=0xa8e5d0, globals=&lt;optimized out&gt;, locals=&lt;optimized out&gt;,
args=0x2088cc8, argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; at Python/ceval.c:2942</font>
<br><font size=2 face="sans-serif">.</font>
<br><font size=2 face="sans-serif">.</font>
<br><font size=2 face="sans-serif">.</font>
<br>
<br><font size=2 face="sans-serif">Any suggestions are welcome.</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 00323AD3C2257BB2_=--



--===============0216067888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0216067888==--
