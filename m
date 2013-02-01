From: Christian Babeux <christian.babeux@efficios.com>
Subject: LTTng & Google Summer of Code 2013
Date: Fri, 1 Feb 2013 11:39:09 -0500
Message-ID: <CAGDH53kvT4dOMc2o4RA4ak56bfxcUaq0MpW9BzPjvt9E-bLn7w__6237.34025653011$1359736809$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1U1Je7-0004sc-IM
	for lttng-dev@lists.lttng.org; Fri, 01 Feb 2013 11:39:23 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so1247552iak.4
	for <lttng-dev@lists.lttng.org>; Fri, 01 Feb 2013 08:39:17 -0800 (PST)
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

Hi everyone,

After some initial discussion with the LTTng developers, we think it
would be a great opportunity for the LTTng project to participate as a
mentoring organisation in Google Summer of Code 2013.

Apparently, some attempts were made in the past years but the
application deadline was missed by a few picoseconds ;).

Here are some of the requirements for a mentoring organisation application [1]:

"
What is the URL for your Ideas page?
What is the main development mailing list for your organization?
What is the main IRC channel for your organization?
Does your organization have an application template you would like to
see students use? If so, please provide it now.
"

One of the *most* important point of this list is to have an idea
pages/list ready for the application.

Here are some projects ideas that a student or intern could
accomplish within the scope of Google Summer of Code:

- Continue the Android port of LTTng
- Continue the work done on Python bindings for babeltrace/lttng-tools.
- Trace probe support in C++ [2].
- A meta-command support in lttng-tools (ex: lttng --trace, see [3]).
- Improve the liblttng-ust-libc-wrapper with additionnal libc functions support.
- LTTV features.
- Implement syscalls on other architectures (maybe not relevant, see [4])
- Hook the trace/debug infrastructure of Wine in UST.
- Etc.

So I'm asking the community for feedback and ideas to get this
application going!

Thanks,

Christian

[1] - https://www.google-melange.com/document/show/gsoc_program/google/gsoc2012/faqs#mentoring_apply
[2] - http://bugs.lttng.org/issues/338
[3] - http://bugs.lttng.org/issues/15
[4] - http://bugs.lttng.org/issues/33
