From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: Running lttng-tools testsuite against an installed
 codebase
Date: Fri, 13 Sep 2013 09:20:31 -0400
Message-ID: <5233111F.7080805__28735.0534498275$1379078500$gmane$org@mentor.com>
References: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1VKTIe-0002oB-9z
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 09:20:45 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VKTIX-0002LA-O1 from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 06:20:33 -0700
In-Reply-To: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
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

On 09/12/2013 06:29 PM, Christian Babeux wrote:
> Hi lttng-testers,
>
> The current lttng-tools testsuite has some limitations as recently
> pointed out on this OpenEmbedded thread [1].
>
> The testsuite cannot be runned against an installed codebase of
> lttng-tools because the tests assume that the lttng cli and the
> testapps are located in the build directory.
>
> Perhaps an env. var. could be used when running the make installcheck target?
>
> Any thoughts on how we could resolve this issue?

I have looked a little more into the test support code. It appears that
at least some test scripts hardcode the path to the lttng binaries
relative to the test directory. Removing those path prefixes indeed
resolved the test failures in the cases I was looking into. Of course,
that would break the `make check` target as for in-development testing
the binaries would no longer be found. Is there any reason a simple
adjustment of the PATH variable would not be enough ?

Thanks,
        Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
