From: Thierry Bultel <thierry.bultel@wanadoo.fr>
Subject: Re: "lttng enable-event" fails
Date: Thu, 26 Jun 2014 15:20:20 +0200
Message-ID: <53AC1E14.4030700__44870.1137713671$1403788900$gmane$org@wanadoo.fr>
References: <53A91EF9.1050006@wanadoo.fr> <20140624135319.GB11698@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]
 helo=smtp.smtpout.orange.fr) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thierry.bultel@wanadoo.fr>) id 1X09bH-0007qO-Ty
 for lttng-dev@lists.lttng.org; Thu, 26 Jun 2014 09:20:32 -0400
In-Reply-To: <20140624135319.GB11698@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Some other useful information probably:
The bug does not happen with the (old) Linaro 2012.10 compiler:

# ./host/usr/bin/arm-linux-gnueabihf-gcc --version
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.7-2012.10-20121022 =

- Linaro GCC 2012.10) 4.7.3 20121001 (prerelease)
Copyright =A9 2012 Free Software Foundation, Inc.

Whereas it happens with the one provided by buildroot:

../buildroot_agv_v15_amos820/host/usr/bin/arm-linux-gcc --version
arm-linux-gcc (Buildroot 2014.02-rc3-00323-g2f12017) 4.7.3
Copyright =A9 2012 Free Software Foundation, Inc.

Thus I am submitting that bug report to buildroot as well.

Regards
Thierry


Le 24/06/2014 15:53, David Goulet a =E9crit :
> On 24 Jun (08:47:21), Thierry Bultel wrote:
>> Hi,
>>
>> I am using lttng (2.4.1), target is ARM Cortex A9; compiler is gcc-4.7.3,
>> but I have the same issue with gcc-4.8.2
>> The kernel is Freescale's 3.0.35-4.1.0
>>
>>
>> lttng fails to start:
>>
>> [root@buildroot ~]# lttng create
>> Session auto-19700319-135920 created.
>> Traces will be written in /root/lttng-traces/auto-19700319-135920
>> [root@buildroot~]# lttng enable-event --kernel --all
>> PERROR [5831/5915]: wait: Success (in run_as_clone() at runas.c:243)
>> Error: Trace directory creation error
>> Error: Events: Kernel create session failed (channel channel0, session
>> auto-19700319-135920)
>>
>> My analysis show that lttng attempts to create the trace directory, when
>> "lttng enable-event" is called.
>> To do so, it uses a slave thread that performs a kind of "mkdir -p" ,
>> that thread is spawned via a call to "clone"
>> and the father waits for it via "waitpid".
>>
>> When the slave returns, waitpid says it is not completed. Added a little
>> code to shows that the thread
>> is killed with SIGSEGV at the time it calls "return"
>>
>> Changing it to call "exit" instead, makes it a little better, but other
>> numerous errors come when
>> calling "lttng start"
>>
>> Did anyone encounter such an issue ?
>
> Hrm, tbh I never tried lttng-tools on ARM but if a SIGSEGV is raised you
> should be able to get a core dump and with gdb we can understand which
> callsite failed badly.
>
> Thanks!
> David
>
>>
>> Best regards
>> Thierry Bultel
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
