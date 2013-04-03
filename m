From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: lttng-tools test suite problem
Date: Wed, 3 Apr 2013 14:38:52 -0400
Message-ID: <CAFXXi0kFSfWVXCT0gcAgF6RfLSL0cUqXtxcPHYmJWcS4tPPm4w__43418.8544554219$1365014416$gmane$org@mail.gmail.com>
References: <CAFXXi0mrOQdqQ-4j27_Eu4oCtfLcxhFF2EdYdy+tZsLZngDeRw@mail.gmail.com>
	<CAGDH53mtYuayRxgteSpZ5w+zkrfZo4rs6wwJBTHFamTSoKqtpA@mail.gmail.com>
	<CAFXXi0nQ1QqF_OPY2wir8qcM+GG1+jkT0W5oi-eNW8t5jOmQAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UNSam-0002Xt-8O
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 14:39:28 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so1543540iag.17
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 11:39:22 -0700 (PDT)
In-Reply-To: <CAFXXi0nQ1QqF_OPY2wir8qcM+GG1+jkT0W5oi-eNW8t5jOmQAg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 3 April 2013 14:28, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Finally, an idea just like that: instead of specifying the source
> file, would it be possible to specify directly the object file (e.g.
> $(top_srcdir)/src/bin/lttng/utils.o or ../../src/bin/lttng/utils.o) in
> LDADD ? So the unit test Makefile would not recompile the unit under
> test, but just link with the object that is already built ?

Hmm, preliminary tests indicate it would work. Example
tests/unit/Makefile.am: http://paste.ubuntu.com/5674448/
