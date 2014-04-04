From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: tracepoint sys_enter and sys_exit
Date: Fri, 4 Apr 2014 16:19:00 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599319C__12551.2035134763$1396628417$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WW6pf-0001yf-8v
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 12:19:13 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Fri, 04 Apr 2014 08:26:52 -0400
From: Francis Giraldeau <francis.giraldeau@gmail.com>
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>

> > But where are these two tracepoints (hits) in kernel source code?
>
> If I remember correctly, for x86_64, the file is arch/x86/kernel/entry_64=
.S and search for syscall_trace_enter.
>
> Francis

   Syscall_trace_enter appears in a handful of .S files (assembly code) in =
the arch hierarchy.  Also ptrace.c and thread_info.h.  If thread info inclu=
des the TIF_SYSCALL_TRACEPOINT flag, in the x86 case this invokes the trace=
point trace_sys_enter (registered and unregistered by kernel/trace/trace_sy=
scalls.c).  The tracepoint provider is the lttng-tracer.ko kernel module.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
