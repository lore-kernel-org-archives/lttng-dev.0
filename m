From: Amit Margalit <AMITM@il.ibm.com>
Subject: Minor documentation issue with 2.4.0
Date: Wed, 2 Apr 2014 12:23:42 +0300
Message-ID: <OF651759A2.C8A68066-ONC2257CAE.00334115-C2257CAE.0033A0AF__1593.1605980315$1396516607$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0748399471=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WVHOt-0006kw-CN
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 05:24:04 -0400
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Wed, 2 Apr 2014 10:23:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE1652190056
 for <lttng-dev@lists.lttng.org>; Wed,  2 Apr 2014 10:23:48 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s329NgTF1507646
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 09:23:42 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s329NsOX011805
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 03:23:54 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s329NsvS011802
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2014 03:23:54 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0748399471==
Content-Type: multipart/alternative; boundary="=_alternative 0033A03AC2257CAE_="

This is a multipart message in MIME format.
--=_alternative 0033A03AC2257CAE_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

I ran a command that included an error, and noticed that 'lttng' mentions 
-j in --buffers-pid and --buffers-uid, but nowhere else:

# /usr/bin/lttng enable-channel -u    
Error: Missing channel name.

usage: lttng enable-channel NAME[,NAME2,...] (-u | -k) [OPTIONS]

Options:
  -h, --help               Show this help
      --list-options       Simple listing of options
  -s, --session NAME       Apply to session name
  -k, --kernel             Apply to the kernel tracer
  -u, --userspace          Apply to the user-space tracer

Channel options:
      --discard            Discard event when buffers are full (default)
      --overwrite          Flight recorder mode
      --subbuf-size SIZE   Subbuffer size in bytes {+k,+M,+G}
                               (default UST uid: 131072, UST pid: 4096, 
kernel: 262144, metadata: 4096)
                               Rounded up to the next power of 2.
      --num-subbuf NUM     Number of subbufers
                               (default UST uid: 4, UST pid: 4, kernel: 4, 
metadata: 2)
                               Rounded up to the next power of 2.
      --switch-timer USEC  Switch timer interval in usec
                               (default UST uid: 0, UST pid: 0, kernel: 0, 
metadata: 0)
      --read-timer USEC    Read timer interval in usec.
                               (default UST uid: 0, UST pid: 0, kernel: 
200000, metadata: 0)
      --output TYPE        Channel output type (Values: mmap, splice)
                               (default UST uid: mmap, UST pid: mmap, 
kernel: splice, metadata: mmap)
      --buffers-uid        Use per UID buffer (-u/-j only)
      --buffers-pid        Use per PID buffer (-u/-j only)
      --buffers-global     Use shared buffer for the whole system (-k 
only)
  -C, --tracefile-size SIZE
                           Maximum size of each tracefile within a stream 
(in bytes). 0 means unlimited.
                               (default: 0)
  -W, --tracefile-count COUNT
                           Used in conjunction with -C option, this will 
limit the number
                           of files created to the specified count. 0 
means unlimited.
                               (default: 0)

Error: Command error

You can see these 2 lines:

      --buffers-uid        Use per UID buffer (-u/-j only)
      --buffers-pid        Use per PID buffer (-u/-j only)

But -j is not explained above.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0033A03AC2257CAE_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I ran a command that included an error,
and noticed that 'lttng' mentions -j in --buffers-pid and --buffers-uid,
but nowhere else:</font>
<br>
<br><tt><font size=2># /usr/bin/lttng enable-channel -u &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; </font></tt>
<br><tt><font size=2>Error: Missing channel name.</font></tt>
<br>
<br><tt><font size=2>usage: lttng enable-channel NAME[,NAME2,...] (-u |
-k) [OPTIONS]</font></tt>
<br>
<br><tt><font size=2>Options:</font></tt>
<br><tt><font size=2>&nbsp; -h, --help &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; Show this help</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --list-options &nbsp; &nbsp;
&nbsp; Simple listing of options</font></tt>
<br><tt><font size=2>&nbsp; -s, --session NAME &nbsp; &nbsp; &nbsp; Apply
to session name</font></tt>
<br><tt><font size=2>&nbsp; -k, --kernel &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; Apply to the kernel tracer</font></tt>
<br><tt><font size=2>&nbsp; -u, --userspace &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;Apply to the user-space tracer</font></tt>
<br>
<br><tt><font size=2>Channel options:</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --discard &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;Discard event when buffers are full (default)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --overwrite &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;Flight recorder mode</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --subbuf-size SIZE &nbsp; Subbuffer
size in bytes {+k,+M,+G}</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid:
131072, UST pid: 4096, kernel: 262144, metadata: 4096)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Rounded up to the
next power of 2.</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --num-subbuf NUM &nbsp; &nbsp;
Number of subbufers</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid:
4, UST pid: 4, kernel: 4, metadata: 2)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Rounded up to the
next power of 2.</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --switch-timer USEC &nbsp;Switch
timer interval in usec</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid:
0, UST pid: 0, kernel: 0, metadata: 0)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --read-timer USEC &nbsp; &nbsp;Read
timer interval in usec.</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid:
0, UST pid: 0, kernel: 200000, metadata: 0)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --output TYPE &nbsp; &nbsp; &nbsp;
&nbsp;Channel output type (Values: mmap, splice)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default UST uid:
mmap, UST pid: mmap, kernel: splice, metadata: mmap)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --buffers-uid &nbsp; &nbsp; &nbsp;
&nbsp;Use per UID buffer (-u/-j only)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --buffers-pid &nbsp; &nbsp; &nbsp;
&nbsp;Use per PID buffer (-u/-j only)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --buffers-global &nbsp; &nbsp;
Use shared buffer for the whole system (-k only)</font></tt>
<br><tt><font size=2>&nbsp; -C, --tracefile-size SIZE</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Maximum size of each tracefile
within a stream (in bytes). 0 means unlimited.</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default: 0)</font></tt>
<br><tt><font size=2>&nbsp; -W, --tracefile-count COUNT</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Used in conjunction with -C option,
this will limit the number</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;of files created to the specified
count. 0 means unlimited.</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(default: 0)</font></tt>
<br>
<br><tt><font size=2>Error: Command error</font></tt>
<br>
<br><font size=2 face="sans-serif">You can see these 2 lines:</font>
<br>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --buffers-uid &nbsp; &nbsp; &nbsp;
&nbsp;Use per UID buffer (-u/-j only)</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; --buffers-pid &nbsp; &nbsp; &nbsp;
&nbsp;Use per PID buffer (-u/-j only)</font></tt>
<br>
<br><font size=2 face="sans-serif">But -j is not explained above.</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0033A03AC2257CAE_=--



--===============0748399471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0748399471==--
