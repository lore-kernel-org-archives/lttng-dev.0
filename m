From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Instrumenting a module?
Date: Mon, 10 Feb 2014 17:10:37 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267E3ED9__19086.203343659$1392052316$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WCuNX-0000ZA-JO
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 12:10:49 -0500
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

   I'm trying to find out the recipe for instrumenting a kernel module with=
 some custom LTTng tracepoints.  Oddly, writing the LTTng tracepoint provid=
er kernel module turned out not too bad (the READMEs help), but I have seen=
 no documentation of the process of instrumenting a module.

   Here is a simple module and its Makefile.  The module works as expected,=
 adding events to the dmesg kernel log buffer upon being loaded and unloade=
d.

######
hello.c
######

#include <linux/module.h>  // included for all kernel modules
#include <linux/kernel.h>  // included for KERN_INFO
#include <linux/init.h>    // included for __init and __exit macros

//Module meta-data
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your name here");
MODULE_DESCRIPTION("A simple module");

//Module initialization
static int __init hello_init(void)
{
   printk(KERN_INFO "Hello!\n");
   return 0;
   // Any other return value means the module couldn't be loaded.
}

//Module finalization
static void __exit hello_cleanup(void)
{
   printk(KERN_INFO "Cleaning up hello module.\n");
}

//Identify the initialization and finalization handlers
module_init(hello_init);
module_exit(hello_cleanup);

######
Makefile
######

obj-m +=3D hello.o

all:
	@echo "~~~~~~Copying hello.h to linux-headers:"
	gksudo cp hello.h /usr/src/linux-headers-3.2.0-53/include/trace/events/hel=
lo.h
	@echo "~~~~~~Copying hello.h to lttng-modules/instrumentation/events/lttng=
-module:"
	sudo cp hello-module.h /usr/src/lttng-modules-2.3.0/instrumentation/events=
/lttng-module/hello.h
	@echo "~~~~~~Copying lttng-probe-hello.c to lttng-modules/probes:"
	sudo cp lttng-probe-hello.c /usr/src/lttng-modules-2.3.0/probes/lttng-prob=
e-hello.c
	@echo "~~~~~~Making hello.ko:"
	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean

hello.h defines the tracepoints for my custom LTTng module (lttng-probe-hel=
lo).  hello-module.h is hello.h "translated" for the lttng-module directory=
.  lttng-probe-hello was added to the probes Makefile.  lttng-modules makes=
 and installs it just fine, and once I manually insmod lttng-probe-hello.ko=
, LTTng reports the new kernel tracepoints in 'lttng list -k'.

I instrument hello.c by adding:

######
hello.c
######

#include <linux/module.h>  // included for all kernel modules
#include <linux/kernel.h>  // included for KERN_INFO
#include <linux/init.h>    // included for __init and __exit macros
#include <trace/events/hello.h>

...

static int __init hello_init(void)
{
   trace_hello_init("Hello!");
   printk(KERN_INFO "Hello!\n");
...

static void __exit hello_cleanup(void)
{
   trace_hello_exit("Bye!");
   printk(KERN_INFO "Cleaning up hello module.\n");
...

I get a couple of warnings when I make the instrumented hello module:

WARNING: "__tracepoint_hello_exit" [/home/daniel/module/hello.ko] undefined!
WARNING: "__tracepoint_hello_init" [/home/daniel/module/hello.ko] undefined!

And hello.ko refuses to insmod as a consequence:

$ sudo insmod hello.ko
insmod: error inserting 'hello.ko': -1 Unknown symbol in module

Assuming I got the LTTng tracepoint provider kernel module right, what am I=
 doing wrong with the instrumented module?  I suspect a missing define flag.
 =

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
