From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Compile failure on OSX 10.8
Date: Fri, 21 Jun 2013 12:51:33 -0400
Message-ID: <CAGDH53mD-8jWechmKhVWyS7nY_CJQQgdDXfLp1V=gsAkmw53eQ__47618.9238172539$1371833529$gmane$org@mail.gmail.com>
References: <51C46FFC.7050407@ripe.net>
	<CAGDH53k9wAeu6cBsSCtauX0ADgFW9B09vz7Cfq2B=Yhw3-pCNw@mail.gmail.com>
	<51C47EE0.9080208@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uq4Yk-0005fQ-Mc
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 12:51:38 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so6489845veb.6
	for <lttng-dev@lists.lttng.org>; Fri, 21 Jun 2013 09:51:33 -0700 (PDT)
In-Reply-To: <51C47EE0.9080208@ripe.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Buddhdev <anandb@ripe.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hmm that's really weird :/. For some reason configure detect an i386
CPU which is certainly not right. Could you post your config.log with
and without the --host flag (specifying which is which)?

There might be some slight incompatibilities on OSX and the CPU
detection mechanism we are using...

Christian



On Fri, Jun 21, 2013 at 12:27 PM, Anand Buddhdev <anandb@ripe.net> wrote:
> Hi Christian,
>
> OSX 10.8 *is* 64-bit. I often compile other stuff on it, and the
> compiler happily produces 64-bit binaries, for example:
>
> $ file ~/Homebrew/Cellar/mutt/1.5.21/bin/mutt
> /Users/anandb/Homebrew/Cellar/mutt/1.5.21/bin/mutt: Mach-O 64-bit
> executable x86_64
>
> I've attached my config.log here (the one that fails to build).
>
> However, I then passed "--host=i686-apple-darwin11" to configure, and
> then make runs just fine, and completes. But the library it produces
> appears to be 64-bit:
>
> $ file .libs/liburcu.1.dylib
> .libs/liburcu.1.dylib: Mach-O 64-bit dynamically linked shared library
> x86_64
>
> What am I missing?
>
> Regards,
>
> Anand
>
> On 21/06/2013 17:54, Christian Babeux wrote:
>
>> Hi Anand,
>>
>> You might have to pass an additional host flag to configure e.g.:
>>
>> ./configure --host=i686-apple-darwin11
>>
>> If I remember correctly, the compiler on OSX was compiled to run on a
>> 64-bit platform but _only_ produce 32-bit binaries. Our configure
>> script wrongly detect an x86-64 host, so you need to force it to use
>> i686.
>>
>> Could you post the output of your config.log?
>>
>> Thanks,
>>
>> Christian
