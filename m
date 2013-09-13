From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Running lttng-tools testsuite against an installed
	codebase
Date: Fri, 13 Sep 2013 15:56:53 -0400
Message-ID: <CAGDH53=XZcss0GgRRRDxW7sqanH_c3Oy2gqMqXUFMG=x48LdwA__8080.03363567895$1379102274$gmane$org@mail.gmail.com>
References: <CAGDH53mDNwdbvhNQFJAAVcECM6ttsv3PjUDCqu3MZitfBrSHbA@mail.gmail.com>
	<5233111F.7080805@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VKZUA-0004Rc-Uv
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 15:57:04 -0400
Received: by mail-ve0-f179.google.com with SMTP id c14so1364198vea.24
	for <lttng-dev@lists.lttng.org>; Fri, 13 Sep 2013 12:56:53 -0700 (PDT)
In-Reply-To: <5233111F.7080805@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Of course, that would break the `make check` target as for in-development testing
> the binaries would no longer be found. Is there any reason a simple
> adjustment of the PATH variable would not be enough ?

One of the issue I see with overriding the PATH _only_ in the make
check target is that we will no longer be able to run each tests
separately from the command line.

Poking a bit around, I saw that the git project also use a TAP
testsuite. They get around the issue of binary path resolving via a
test-lib (similar to our tests/utils/utils.sh) which is sourced in
each scripts and adjust the paths accordingly. E.g (from git t/README
[1]).:

"You can also set the GIT_TEST_INSTALLED environment variable to the
bindir of an existing git installation to test that installation. You
still need to have built this git sandbox, from which various test-*
support programs, templates, and perl libraries are used."

Also, see [2] for the relevants checks around "GIT_EXEC_PATH".

We could fix our testsuite in a similar fashion:

- Put the logic of lttng/sessiond/relayd path detection in tests/utils/utils.sh

    * If "LTTNG_EXEC_PATH" not specified, use the binaries found in
the build dir and adjust PATH.
    * If "LTTNG_EXEC_PATH" specified, use this path instead and adjust PATH.

- Source utils.sh in every tests (already done).

- In the make installcheck target, export LTTNG_EXEC_PATH with the
appropriate installed binary path.

Thoughts?

Christian

[1] - https://raw.github.com/git/git/master/t/README
[2] - https://raw.github.com/git/git/master/t/test-lib.sh

On Fri, Sep 13, 2013 at 9:20 AM, Stefan Seefeld
<stefan_seefeld@mentor.com> wrote:
> On 09/12/2013 06:29 PM, Christian Babeux wrote:
>> Hi lttng-testers,
>>
>> The current lttng-tools testsuite has some limitations as recently
>> pointed out on this OpenEmbedded thread [1].
>>
>> The testsuite cannot be runned against an installed codebase of
>> lttng-tools because the tests assume that the lttng cli and the
>> testapps are located in the build directory.
>>
>> Perhaps an env. var. could be used when running the make installcheck target?
>>
>> Any thoughts on how we could resolve this issue?
>
> I have looked a little more into the test support code. It appears that
> at least some test scripts hardcode the path to the lttng binaries
> relative to the test directory. Removing those path prefixes indeed
> resolved the test failures in the cases I was looking into. Of course,
> that would break the `make check` target as for in-development testing
> the binaries would no longer be found. Is there any reason a simple
> adjustment of the PATH variable would not be enough ?
>
> Thanks,
>         Stefan
>
>
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
