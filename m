From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: lttng ubuntu .deb packages - compilation error
Date: Thu, 12 Jun 2014 20:55:48 -0400
Message-ID: <539A4C14.5080302__39562.8238017254$1402621001$gmane$org@voxpopuli.im>
References: <CAM5kDqxJSHNcEj7=Jv+yDNJk9+bPCwTEjvYgdk36Pz8iMcw+qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WvFmc-00062W-J7
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 20:56:00 -0400
In-Reply-To: <CAM5kDqxJSHNcEj7=Jv+yDNJk9+bPCwTEjvYgdk36Pz8iMcw+qQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Did you install the "liblttng-ust-dev" package? That one is required if
you want to compile applications against UST.

sdt.h comes from "systemtap-sdt-dev", which liblttng-ust-dev depends on,
so it should get pulled in automatically once you install the dev package.

One more comment below:


On 14-06-12 05:34 PM, Anand Neeli wrote:
> Hi All,
> I'm using a i386 ubuntu deb package to get include file of lttng-ust and
> urcu
> I have just instrumented with a basic tracepoint, my tracepoint .c and .h
> look good.
>
> i get following error fatal error: sys/sdt.h: No such file or directory
>
> /home/aneeli/evo_all/cevo/liblogtrace_test/src/logtrace_test.c
> In file included from
> /home/aneeli/evo_all/cevo/liblogtrace_test/src/logtest_tracepoint.h:11:0,
>                  from
> /home/aneeli/evo_all/cevo/liblogtrace_test/src/logtrace_test.c:18:
> /home/aneeli/evo_all/cevo/lttng/obj-native/install/usr/include/lttng/tracepoint.h:38:21:
> fatal error: sys/sdt.h: No such file or directory
> compilation terminated.
>
> looks like LTTNG_UST_HAVE_SDT_INTEGRATION flag is set in deb i386 files
> lttng/ust-config.h:
> #define LTTNG_UST_HAVE_SDT_INTEGRATION 1
>
> Where as LTTNG_UST_HAVE_SDT_INTEGRATION=1 is commented when i compile
> manually for some other platforms

That's expected, because the SDT integration is not enabled by default.
You have to pass --with-sdt to configure to enable it. Which we do in
the Debian/Ubuntu packages, since the sdt.h header is easily available.


Cheers,
Alexandre


>
> Am i missing anything here?
> how can i compile for i386 using include files from deb.
>
>
> Thanks,
> Anand Neeli
>
>
>
> On Fri, Jun 13, 2014 at 12:28 AM, Alexandre Montplaisir <
> alexmonthy@voxpopuli.im> wrote:
>
>>  Yes! There are PPAs for Ubuntu packages, one for the stable branches:
>> https://launchpad.net/~lttng/+archive/ppa
>>
>> and one for builds of the git master:
>> https://launchpad.net/~lttng/+archive/daily
>>
>>
>> Cheers,
>> Alexandre
>>
>>
>>
>> On 06/12/2014 02:27 PM, Anand Neeli wrote:
>>
>> Hi All,
>> are there latest ubuntu .deb of lttng-ust, lttng-ust-dev, liburcu,
>> liburcu-dev available?
>> i'm looking for i386 and amd64 CPU target
>> if yes, can some one tell me the location to download?
>>
>> i'm able to find older versions in http://packages.ubuntu.com, but i'm
>> looking for the latest deb files
>>
>> Thanks,
>> Anand Neeli
>>
>>
