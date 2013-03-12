From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Correct LTTng version
Date: Tue, 12 Mar 2013 17:38:13 -0400
Message-ID: <513FA045.401__49217.3138227828$1363124318$gmane$org@efficios.com>
References: <14dbf3b61272282c1f4163c8a1a2f2b681f3989c.1363123481.git.raphael.beamonte@gmail.com>
	<513F9DF1.9030909@efficios.com>
	<CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A@mail.gmail.com>
	<513F9F81.9040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UFWtQ-0003Wy-9G
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 17:37:56 -0400
In-Reply-To: <513F9F81.9040909@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Yup that would be ideal actually!

Master is not 2.0 nor 2.1 so having something like
"git-FIRST_8_BYTES_OF_HEAD_COMMIT" would be very useful.

Thanks!
David

Yannick Brosseau:
> Maybe we should find a way to add the git commit id and maybe other git
> info to the version display when we build it from git.
> =

> On 2013-03-12 17:31, Rapha=EBl Beamonte wrote:
>> Hi David,
>>
>> The tag version changed in LTTng but not the displayed version, and it
>> made me remove the whole LTTng tools from my computer and reinstall
>> them as I didn't understand why the version number displayed wasn't
>> the one from the version I was installing. It's not a very important
>> bug, but it could be a time consumer one...
>>
>> Rapha=EBl
>>
>> 2013/3/12 David Goulet <dgoulet@efficios.com
>> <mailto:dgoulet@efficios.com>>
>>
>>     Hi Rapha=EBl,
>>
>>     This is not very relevant because we branch at each release so the
>>     master version is a bit useless.
>>
>>     Do you have a need for that?
>>
>>     Thanks
>>     David
>>
>>     Rapha=EBl Beamonte:
>>     > Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com
>>     <mailto:raphael.beamonte@gmail.com>>
>>     > ---
>>     >  configure.ac <http://configure.ac> |    2 +-
>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>>     >
>>     > diff --git a/configure.ac <http://configure.ac> b/configure.ac
>>     <http://configure.ac>
>>     > index 7e35c06..c8aa034 100644
>>     > --- a/configure.ac <http://configure.ac>
>>     > +++ b/configure.ac <http://configure.ac>
>>     > @@ -1,4 +1,4 @@
>>     > -AC_INIT([lttng-tools],[2.1.0],[dgoulet@efficios.com
>>     <mailto:dgoulet@efficios.com>],[],[http://lttng.org])
>>     > +AC_INIT([lttng-tools],[2.1.1],[dgoulet@efficios.com
>>     <mailto:dgoulet@efficios.com>],[],[http://lttng.org])
>>     >  AC_CONFIG_AUX_DIR([config])
>>     >  AC_CANONICAL_TARGET
>>     >  AC_CANONICAL_HOST
>>
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
