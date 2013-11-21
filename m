From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a modul (driver)
Date: Thu, 21 Nov 2013 17:42:00 +0100
Message-ID: <528E37D8.3060606__24014.4280520783$1385052152$gmane$org@gmx.de>
References: <527DF369.4020704@gmx.de>	<5283B8BD.9020703@gmx.de>	<528DD70B.8040504@gmx.de>
	<CA+jJMxsybZ4mo1Mp369hhgNSCi-pfNh8VG1F5S2H5DpKL5nSsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.15])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VjXJt-0003fo-Vp
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 11:41:40 -0500
Received: from [192.168.178.21] ([88.64.178.221]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0MWSwU-1WBbm60YjC-00XgH8 for
	<lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 17:41:28 +0100
In-Reply-To: <CA+jJMxsybZ4mo1Mp369hhgNSCi-pfNh8VG1F5S2H5DpKL5nSsw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 21.11.2013 16:49, schrieb J=E9r=E9mie Galarneau:
> On Thu, Nov 21, 2013 at 4:48 AM, Klaus Dannecker <klaus.dannecker@gmx.de>=
 wrote:
>> Hi,
>>
>> Nobody can help me?
>>
>> now i have ubuntu 13.10 installed  in a vmware.
>> but i have the same error!
>>
>> s$ sudo make modules_install
>> make -C /lib/modules/3.11.0-12-generic/build
>> M=3D/home/klaus/lttng_src/lttng-modules modules_install
>> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>>    INSTALL /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer=
.ko
>>
>> Can't read private key
> Ubuntu now ships with module signing enabled by default.
> Does the installation fail, or is it just a warning?
i don't know
>> ....
>> lsmod | grep lttng
>> -> no module found
>>
> The modules will not be automatically loaded after being built and
> installed. You have to launch lttng-sessiond (as root) for that. What
> is the output of the following commands?
>
> make
> sudo make modules_install
> sudo depmod -a
> sudo lttng-sessiond &
> lsmod | grep lttng
klaus@ubuntu:~/lttng_src/lttng-modules$ make
make -C /lib/modules/3.11.0-12-generic/build =

M=3D/home/klaus/lttng_src/lttng-modules modules
make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
/home/klaus/lttng_src/lttng-modules/probes/Makefile:30: File =

/usr/src/linux-headers-3.11.0-12-generic/virt/kvm/iodev.h not found. =

Probe "kvm" x86-specific is disabled. Use full kernel source tree to =

enable it.
/home/klaus/lttng_src/lttng-modules/probes/Makefile:81: Files =

/usr/src/linux-headers-3.11.0-12-generic/fs/ext3/*.h not found. Probe =

"ext3" is disabled. Use full kernel source tree to enable it.
/home/klaus/lttng_src/lttng-modules/probes/Makefile:142: Files =

/usr/src/linux-headers-3.11.0-12-generic/fs/btrfs/*.h not found. Probe =

"btrfs" is disabled. Use full kernel source tree to enable it.
/home/klaus/lttng_src/lttng-modules/probes/Makefile:158: Files =

/usr/src/linux-headers-3.11.0-12-generic/fs/ext4/*.h not found. Probe =

"ext4" is disabled. Use full kernel source tree to enable it.
   Building modules, stage 2.
   MODPOST 44 modules
make[1]: Leaving directory `/usr/src/linux-headers-3.11.0-12-generic'

klaus@ubuntu:~/lttng_src/lttng-modules$ sudo make modules_install
make -C /lib/modules/3.11.0-12-generic/build =

M=3D/home/klaus/lttng_src/lttng-modules modules_install
make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
   INSTALL /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
Can't read private key
   INSTALL =

/home/klaus/lttng_src/lttng-modules/lttng-ring-buffer-client-discard.ko
Can't read private key
...
   DEPMOD  3.11.0-12-generic
make[1]: Leaving directory `/usr/src/linux-headers-3.11.0-12-generic'
klaus@ubuntu:~/lttng_src/lttng-modules$

klaus@ubuntu:~/lttng_src/lttng-modules$ sudo depmod -a
klaus@ubuntu:~/lttng_src/lttng-modules$
klaus@ubuntu:~/lttng_src/lttng-modules$ sudo lttng-sessiond &
[1] 23486
klaus@ubuntu:~/lttng_src/lttng-modules$ lsmod | grep lttng

[1]+  Stopped                 sudo lttng-sessiond
klaus@ubuntu:~/lttng_src/lttng-modules$

Thanks for your help!

Regards,
Klaus
> Regards,
> J=E9r=E9mie
>
>> Thanks!
>>
>> Am 13.11.2013 18:37, schrieb Klaus Dannecker:
>>
>>
>> Am 09.11.2013 09:33, schrieb Klaus Dannecker:
>>
>> Hi,
>> I want to write a driver with trace events.
>> In the first step i compile the example  trace-events-sample.c with the
>> makefile:
>>
>> ifneq ($(KERNELRELEASE),)
>>      obj-m  :=3D modul_trace-events-sample.o
>>      modul_trace-events-sample-y :=3D trace-events-sample.o
>>      ccflags-y :=3D -I$(src)
>> else
>>      KDIR ?=3D /lib/modules/`uname -r`/build
>> default:
>>      $(MAKE) -C $(KDIR) M=3D$$PWD
>> endif
>>
>> now i get the modul_trace-events-sample.ko File.
>> now:
>> insmod modul_trace-events-sample.ko
>> lttng create
>> lttng enable-event -k -a
>> lttng start
>> ...wait...
>> lttng stop
>> lttng destroy
>>
>> now i look the result in the eclise viewer, but i found event
>> "trace_foo_bar" not in the session!
>> what am I doing wrong?
>>
>> I use ubuntu 13.04 in a vmware
>>
>> Thanks
>>
>> _______________________________________________
>>
>> Hi,
>>
>> now i found a answer:
>> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
>> now i download the lttng-module and compiled it.
>>
>> $ git clone git://git.lttng.org/lttng-modules.git
>> $ cd lttng-tools
>> $ make
>> $ sudo make modules_install
>> here I get error
>> INSTALL /mnt/hgfs/shared_Folder/lttng-modules/lib/lttng-lib-ring-buffer.=
ko
>> Can't read private key
>> ...
>> what does that mean?
>> what should I do?
>>
>> please help me!
>>
>> another question:
>> when i create a trace events in module_a,
>> can i use it in module_b?
>> if yes, what should I do?
>>
>> thanks Klaus
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
