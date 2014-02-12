From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Instrumenting a module?
Date: Wed, 12 Feb 2014 15:41:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267E62C0__34885.9531026848$1392219750$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WDbwB-0006Ey-Sh
	for lttng-dev@lists.lttng.org; Wed, 12 Feb 2014 10:41:29 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   Further update.  So far I can make plain payload fields and static array=
 payload fields.  But I can't make dynamic array fields (same problem as wi=
th strings, I'm sure, since a string is just a dynamic array of char).

   The tracepoint:

TRACE_EVENT(hello_exit,
   TP_PROTO(int * intarr, unsigned short len),
   TP_ARGS(intarr, len),
   TP_STRUCT__entry(
      __dynamic_array(int, anarray, len)
   ),
   TP_fast_assign(
      memcpy(__entry->anarray, intarr, len*sizeof(int));
   ),
   TP_printk(
      "%s", "printk says bye"
   )
);

   The TP_fast_assign of the lttng-module version uses:
tp_memcpy(anarray, intarr, len*sizeof(int))

   The make of the module calling trace_hello_exit() says:

make -C /lib/modules/3.2.0-53-virtual/build M=3D/home/daniel/Documents/mymo=
dule modules
make[1]: entrant dans le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-v=
irtual =BB
  CC [M]  /home/daniel/Documents/mymodule/hello.o
In file included from include/trace/ftrace.h:567:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/hello.h:130,
                 from /home/daniel/Documents/mymodule/hello.c:5:
include/trace/events/hello.h: In function 'ftrace_raw_event_hello_exit':
include/trace/events/hello.h:87:1: erreur: 'struct ftrace_raw_hello_exit' h=
as no member named 'anarray'
In file included from include/trace/ftrace.h:774:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/hello.h:130,
                 from /home/daniel/Documents/mymodule/hello.c:5:
include/trace/events/hello.h: In function 'perf_trace_hello_exit':
include/trace/events/hello.h:87:1: erreur: 'struct ftrace_raw_hello_exit' h=
as no member named 'anarray'
make[2]: *** [/home/daniel/Documents/mymodule/hello.o] Erreur 1
make[1]: *** [_module_/home/daniel/Documents/mymodule] Erreur 2
make[1]: quittant le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-virtu=
al =BB
make: *** [all] Erreur 2

   Why was perf dragged into this?  The __string attempt only had an ftrace=
 failure.

   Please help untangle this.

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
