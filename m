From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: How do you write an argument-less or payload-less
	kernel tracepoint?
Date: Wed, 12 Feb 2014 21:54:55 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267E73BC__29433.8077809245$1392242170$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WDhlm-0000gW-5P
	for lttng-dev@lists.lttng.org; Wed, 12 Feb 2014 16:55:07 -0500
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

   How do you write an argument-less kernel tracepoint?  I tried:

TRACE_EVENT(hello_nil,
   TP_PROTO(),
   TP_ARGS(),
...
);

and

TRACE_EVENT_NOARGS(hello_nil,
// TP_PROTO(int x),
// TP_ARGS(x),
...
);

   Without success.

   A payload-less tracepoint is possible, but causes a couple of warnings:

make[1]: entrant dans le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-v=
irtual =BB
  CC [M]  /home/daniel/Documents/mymodule/hello.o
In file included from include/trace/ftrace.h:356:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/hello.h:151,
                 from /home/daniel/Documents/mymodule/hello.c:5:
include/trace/events/hello.h: In function 'ftrace_define_fields_hello_nil':
include/trace/events/hello.h:130:1: attention : unused variable 'field' [-W=
unused-variable]
include/trace/events/hello.h:130:1: attention : 'ret' is used uninitialized=
 in this function [-Wuninitialized]
  Building modules, stage 2.
  MODPOST 1 modules
  LD [M]  /home/daniel/Documents/mymodule/hello.ko
make[1]: quittant le r=E9pertoire =AB /usr/src/linux-headers-3.2.0-53-virtu=
al =BB

   Is it possible to get rid of the warnings?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
