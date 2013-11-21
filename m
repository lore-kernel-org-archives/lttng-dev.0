From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a modul (driver)
Date: Thu, 21 Nov 2013 10:49:09 -0500
Message-ID: <CA+jJMxsybZ4mo1Mp369hhgNSCi-pfNh8VG1F5S2H5DpKL5nSsw__22958.657219033$1385049026$gmane$org@mail.gmail.com>
References: <527DF369.4020704@gmx.de> <5283B8BD.9020703@gmx.de>
	<528DD70B.8040504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VjWVH-0000Kz-Q0
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 10:49:21 -0500
Received: by mail-qe0-f51.google.com with SMTP id d4so3910277qej.10
	for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 07:49:10 -0800 (PST)
In-Reply-To: <528DD70B.8040504@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Nov 21, 2013 at 4:48 AM, Klaus Dannecker <klaus.dannecker@gmx.de> w=
rote:
> Hi,
>
> Nobody can help me?
>
> now i have ubuntu 13.10 installed  in a vmware.
> but i have the same error!
>
> s$ sudo make modules_install
> make -C /lib/modules/3.11.0-12-generic/build
> M=3D/home/klaus/lttng_src/lttng-modules modules_install
> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>   INSTALL /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
>
> Can't read private key

Ubuntu now ships with module signing enabled by default.
Does the installation fail, or is it just a warning?

> ....
> lsmod | grep lttng
> -> no module found
>

The modules will not be automatically loaded after being built and
installed. You have to launch lttng-sessiond (as root) for that. What
is the output of the following commands?

make
sudo make modules_install
sudo depmod -a
sudo lttng-sessiond &
lsmod | grep lttng

Regards,
J=E9r=E9mie

> Thanks!
>
> Am 13.11.2013 18:37, schrieb Klaus Dannecker:
>
>
> Am 09.11.2013 09:33, schrieb Klaus Dannecker:
>
> Hi,
> I want to write a driver with trace events.
> In the first step i compile the example  trace-events-sample.c with the
> makefile:
>
> ifneq ($(KERNELRELEASE),)
>     obj-m  :=3D modul_trace-events-sample.o
>     modul_trace-events-sample-y :=3D trace-events-sample.o
>     ccflags-y :=3D -I$(src)
> else
>     KDIR ?=3D /lib/modules/`uname -r`/build
> default:
>     $(MAKE) -C $(KDIR) M=3D$$PWD
> endif
>
> now i get the modul_trace-events-sample.ko File.
> now:
> insmod modul_trace-events-sample.ko
> lttng create
> lttng enable-event -k -a
> lttng start
> ...wait...
> lttng stop
> lttng destroy
>
> now i look the result in the eclise viewer, but i found event
> "trace_foo_bar" not in the session!
> what am I doing wrong?
>
> I use ubuntu 13.04 in a vmware
>
> Thanks
>
> _______________________________________________
>
> Hi,
>
> now i found a answer:
> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
> now i download the lttng-module and compiled it.
>
> $ git clone git://git.lttng.org/lttng-modules.git
> $ cd lttng-tools
> $ make
> $ sudo make modules_install
> here I get error
> INSTALL /mnt/hgfs/shared_Folder/lttng-modules/lib/lttng-lib-ring-buffer.ko
> Can't read private key
> ...
> what does that mean?
> what should I do?
>
> please help me!
>
> another question:
> when i create a trace events in module_a,
> can i use it in module_b?
> if yes, what should I do?
>
> thanks Klaus
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
