From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to more
 detailed match to kernel versions
Date: Thu, 29 Nov 2012 10:11:05 +0100
Message-ID: <50B726A9.7010008__11102.6892009706$1354180369$gmane$org@mentor.com>
References: <1354096526-22098-1-git-send-email-andrew_gabbasov@mentor.com>,
	<20121128155032.GA9266@Krystal>
	<6C5EA58090A5ED459815C4D04C2B466F8C566A47@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Te08o-0002lR-NE
	for lttng-dev@lists.lttng.org; Thu, 29 Nov 2012 04:10:42 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Te08i-0003MT-Gh from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 29 Nov 2012 01:10:36 -0800
In-Reply-To: <6C5EA58090A5ED459815C4D04C2B466F8C566A47@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 11/28/2012 06:16 PM, Gabbasov, Andrew wrote:
>>> The code was verified to compile with latest versions in all stable
>>> branches from 2.6.38.x to 3.6.x and 3.7-rc7.
>>
>> I get this build failure on 3.5 with this patch:
>>
>>   CC [M]  /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.o
>> /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.c:30:29: fatal
>> error: ../fs/ext3/ext3.h: No such file or directory
>> compilation terminated.
>>
>> can you look into it and submit a revised patch ?
> =

> You must be using kernel headers for building lttng-modules (linux-header=
s package
> or something like that), right? This is what I was writing about: since e=
xt3.h is not available
> in kernel's "include" directory, and in order to avoid duplicating this f=
ile in lttng-modules
> sources, we have to use that <../> based reference, and this requires hav=
ing full kernel
> source for building. The same issue will later be with btrfs and ext4 pro=
bes: their necessary
> include files are also not available in kernel headers. =


I agree with Andrew. The problem is that some newer ftrace probes are
written in a way that you have to have the full kernel source tree to
build against them. For the ext3 probe I used a workaround and copied
the included header from fs/ext3/ext3.h to
instrumentation/events/mainline/fs_ext3.h to allow building without the
full kernel source tree. But for the btrfs (and also the ext4) probe
this will not work because they require even more headers that are not
part of the kernel include dir.

--
Paul

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
