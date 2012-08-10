From: David Goulet <dgoulet@efficios.com>
Subject: Re: qemuarm: Session dameon died (exit status 0)
Date: Fri, 10 Aug 2012 10:43:21 -0400
Message-ID: <50251E09.6010703__2492.65184761516$1344609851$gmane$org@efficios.com>
References: <CAKe51+3mCaia8a--vH8KVbtA+kkzGsKx2=C0-K1qEvNY42wRkQ@mail.gmail.com>
	<50251B38.8040205@gmail.com>
	<CAKe51+2cNmVj7tjdtUwPJ2cuG=Rsa3qKKFGjV1JNL6_vBZY_1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SzqQv-0005VW-U1
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 10:43:26 -0400
In-Reply-To: <CAKe51+2cNmVj7tjdtUwPJ2cuG=Rsa3qKKFGjV1JNL6_vBZY_1A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Barrette <paulbarrette@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

That's interesting!

Could you send us the gdb backtrace

$ gdb lttng-sessiond
gdb> r
gdb> bt full

And seems you use "-ww" instead of "-vvv" ... I doubt the segfault is
in the option parsing but still.

Thanks!
David

Paul Barrette:
> 
> 
> On Fri, Aug 10, 2012 at 10:31 AM, Yannick Brosseau 
> <yannick.brosseau@gmail.com <mailto:yannick.brosseau@gmail.com>>
> wrote:
> 
> Hi,
> 
> Can you try to start the lttng-sessiond manually and see if there
> is error message (with full logging enabled: lttng-sessiond -vvv)
> 
> Hi, # lttng-sessiond -ww Segmentation fault.
> 
> 
> Pb
> 
> Yannick
> 
> 
> On 2012-08-10 10:02, Paul Barrette wrote:
>> Hi all, lttng-modules 2.0.4 lttng-tools 2.0.4 linux kernel 3.4.x
>> 
>> I am running  qemuarm and seeing the following issue when
>> running "lttng create": Error: Session daemon died (exit status
>> 0)
>> 
>> Is there a patch I am missing for arm?
>> 
>> Thanks Pb
>> 
>> -- -- Paul Barrette Linked In Profile 
>> <http://ca.linkedin.com/pub/paul-barrette/11/b42/a96> 
>> http://sitarplayer.net ? \\=^% (*)---(*) ^^~~^~~~^^^~~^
>> 
>> 
>> 
>> 
>> _______________________________________________ lttng-dev mailing
>> list lttng-dev@lists.lttng.org
>> <mailto:lttng-dev@lists.lttng.org> 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> 
> 
> -- -- Paul Barrette Linked In Profile
> <http://ca.linkedin.com/pub/paul-barrette/11/b42/a96> 
> http://sitarplayer.net ? \\=^% (*)---(*) ^^~~^~~~^^^~~^
> 
> 
> 
> 
> This body part will be downloaded on demand.
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQJR4JAAoJEELoaioR9I02n+IIALs8mfV9uxPqTqn7w0aEWhlG
M1RYNwP5nPcaqYeZxptaMR3N5jziPTQZPiVgUZWGlapcguTHmi8gvYkcrYuQnBPs
58P57eCAwo43SX1j5JHNWq6NfP+TsslrlyUESDXNlzLLk2YcZ2uOPrpIby1q0TyP
wpSLGtpWhWXRD71KdY0kKChQ6UOWQZiDNzrbtz9wc4UWiOqcLr9Mf8BXu+qN/Czh
sUrU3HTN2nMn6pG6RopXcqVEHvSw1KKrIXqqcSVCnYsmveEbtIkXvYdYeiQmEFlO
L99VBC8CBva1zh3nkA8KriE94CA0j5WL7oFbjM7F6q3EAVaNw+g668zHkWdocJE=
=9I9j
-----END PGP SIGNATURE-----
