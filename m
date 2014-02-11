From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Instrumenting a module?
Date: Tue, 11 Feb 2014 16:45:59 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267E60F9__48796.3473461152$1392137241$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WDGTF-0003QM-DU
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 11:46:11 -0500
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

----------------------------------------------------------------------
> Date: Mon, 10 Feb 2014 17:10:37 +0000
> From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
>
>    I'm trying to find out the recipe for instrumenting a kernel module wi=
th some custom LTTng tracepoints.
>  Oddly, writing the LTTng tracepoint provider kernel module turned out no=
t too bad (the READMEs help),
> but I have seen no documentation of the process of instrumenting a module.

   Update.  Looking at the instrumented kernel compilation units and define=
_trace.h, I've come to think I must #define CREATE_TRACE_POINTS just before=
 #include <trace/events/hello.h> in the instrumented module.  What I find b=
izarre, though, is that this works for an integer payload field (instrument=
ed module and LTTng tracepoint provider kernel module compile, tracing the =
new kernel events works as expected) but fails miserably with a string payl=
oad field.  Looking at other kernel tracepoints that have string payload fi=
elds, I just don't see what I'm doing wrong.

   The integer tracepoint:

TRACE_EVENT(hello_init,
   TP_PROTO(int anint),
   TP_ARGS(anint),
   TP_STRUCT__entry(
      __field(int, aninteger)
   ),
   TP_fast_assign(
      __entry->aninteger =3D anint;
   ),
   TP_printk(
      "hello=3D%d", __entry->aninteger
   )
);

   The string tracepoint:

TRACE_EVENT(hello_init,
   TP_PROTO(const char * astring),
   TP_ARGS(astring),
   TP_STRUCT__entry(
      __string(hello_string, astring)
   ),
   TP_fast_assign(
      __assign_str(hello_string, astring);
   ),
   TP_printk(
      "hello=3D%s", __entry->hello_string
   )
);

   This time the make says:

make -C /lib/modules/3.2.0-53-virtual/build M=3D/home/daniel/Documents/mymo=
dule modules
make[1]: entrant dans le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-v=
irtual =BB
  CC [M]  /home/daniel/Documents/mymodule/hello.o
In file included from include/trace/ftrace.h:296:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/hello.h:110,
                 from /home/daniel/Documents/mymodule/hello.c:5:
include/trace/events/hello.h: In function 'ftrace_raw_output_hello_init':
include/trace/events/hello.h:57:1: erreur: 'struct ftrace_raw_hello_init' h=
as no member named 'hello_string'
make[2]: *** [/home/daniel/Documents/mymodule/hello.o] Erreur 1
make[1]: *** [_module_/home/daniel/Documents/mymodule] Erreur 2
make[1]: quittant le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-virtu=
al =BB
make: *** [all] Erreur 2

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
