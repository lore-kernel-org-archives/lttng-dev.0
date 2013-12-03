From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-tools build error: non-dynamic relocations
 refer to dynamic symbol lttcomm_inet_tcp_timeout
Date: Tue, 3 Dec 2013 10:34:19 -0500
Message-ID: <CA+jJMxvb-O2m-cGE09BPWRW8Cq15cWfbbRNrFE-XGohjzfVyVQ__2393.65579695932$1386084925$gmane$org@mail.gmail.com>
References: <CAO_ArvpzYu+bVKKi956eiObSd+sg-6Aarhy+h5MZqcDk5S-eqg@mail.gmail.com>
	<20131128203243.GC8372@thessa>
	<CAO_ArvrUNYCd7+1e8hG=fdc84011zMKLjcLg-Ra8qc9Z8ABhgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VnrzV-0001td-7L
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 10:34:30 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so888386qcz.30
	for <lttng-dev@lists.lttng.org>; Tue, 03 Dec 2013 07:34:19 -0800 (PST)
In-Reply-To: <CAO_ArvrUNYCd7+1e8hG=fdc84011zMKLjcLg-Ra8qc9Z8ABhgg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Dec 3, 2013 at 3:23 AM, kumar s <skumar.m226@gmail.com> wrote:
> Hello,
>
> I was able to fix this. I downloaded the latest binutils 2.23 and when mi=
ps
> gcc used the ld from binutils (2.23) , it did not throw any error. The bu=
ild
> went through without any issues.
>
> Do i also need to build lttng modules to start / stop the trace?
>

lttng-modules is only necessary if you wish to use the kernel tracing featu=
res.

J=E9r=E9mie

> Thank you
> Skumar.
>
>
> On Fri, Nov 29, 2013 at 2:02 AM, David Goulet <dgoulet@efficios.com> wrot=
e:
>>
>> On 27 Nov (15:37:10), kumar s wrote:
>> > Hi,
>> >
>> > I am getting non dynamic relocation error while trying to build
>> > lttng-tools. I have configured the lttng-tools for mips-gcc.
>> >
>> > Making all in lttng-sessiond
>> > make[3]: Entering directory
>> > `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
>> >   CC     utils.o
>> >   CC     trace-kernel.o
>> >   CC     kernel.o
>> >   CC     context.o
>> >   CC     channel.o
>> >   CC     event.o
>> >   CC     shm.o
>> >   CC     consumer.o
>> >   CC     session.o
>> >   CC     modprobe.o
>> >   CC     fd-limit.o
>> >   CC     kernel-consumer.o
>> >   CC     cmd.o
>> >   CC     buffer-registry.o
>> >   CC     ht-cleanup.o
>> >   CC     snapshot.o
>> >   CC     jul.o
>> >   CC     main.o
>> > main.c: In function 'thread_dispatch_ust_registration':
>> > main.c:1564: warning: 'cds_wfq_dequeue_blocking' is deprecated (declar=
ed
>> > at
>> >
>> > /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:88)
>> > main.c: In function 'thread_registration_apps':
>> > main.c:1917: warning: 'cds_wfq_enqueue' is deprecated (declared at
>> >
>> > /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:76)
>> > main.c: In function 'main':
>> > main.c:4891: warning: 'cds_wfq_init' is deprecated (declared at
>> >
>> > /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/includ=
e/urcu/wfqueue.h:70)
>> >   CCLD   lttng-sessiond
>> >
>> > /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SD=
K/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mi=
ps64-octeon-linux-gnu/bin/ld:
>> > non-dynamic relocations refer to dynamic symbol lttcomm_inet_tcp_timeo=
ut
>> >
>> > /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SD=
K/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mi=
ps64-octeon-linux-gnu/bin/ld:
>> > failed to set dynamic section sizes: Bad value
>>
>> Looks quite the same here:
>> https://sourceware.org/bugzilla/show_bug.cgi?id=3D10144#c8
>>
>> It seems that this is a gcc bug with -g. I'm not too familiar with MIPS
>> but you could try removing the -g or using "-mplt" as stated in the bug.
>>
>> Cheers!
>> David
>>
>> > collect2: ld returned 1 exit status
>> > make[3]: *** [lttng-sessiond] Error 1
>> > make[3]: Leaving directory
>> > `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
>> > make[2]: *** [all-recursive] Error 1
>> > make[2]: Leaving directory
>> > `/home/shkumar/lttng-tools/lttng-tools/src/bin'
>> > make[1]: *** [all-recursive] Error 1
>> > make[1]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src'
>> > make: *** [all-recursive] Error 1
>> >
>> > Thank you
>> > Skumar
>>
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
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
