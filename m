From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RFC] LTTng Contributor's guide
Date: Mon, 26 Aug 2013 13:39:37 -0400
Message-ID: <CA+jJMxt2AB1MdARo3suHGgnvJmBL-No-YpTWZWQeMfqFUADOtw__37621.3128249676$1377538847$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VE0lT-0004ZT-Eh
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 13:39:49 -0400
Received: by mail-wi0-f169.google.com with SMTP id l12so4395661wiv.4
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 10:39:37 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

There was some talk on the IRC channel last week about the need for a
contributor's guide. I have worked on a quick first draft which you
may find below. Ideally, this would be posted on the LTTng website.

Feedback would be greatly appreciated.

Thanks,
J=E9r=E9mie


*** Contributor's guide ***

Being an open source project, the LTTng project welcomes contributions
from everyone.
This guide will walk you through the process of contributing a patch to LTT=
ng.

Getting the source code
-----------------------

The LTTng project uses Git for source control. How to use Git is
beyond the scope of this guide, but its official website[1] provides
many great tutorials.
Please refer to the download[2] page for links to LTTng's Git repositories.

Fixes and features should generally be developed against the master
branch. If you intend on submitting a patch that addresses an issue in
a specific stable branch or a development branch, make sure you
mention it in the commit's description or the subject prefix.

Coding standard
-------------

LTTng uses the Linux kernel coding style[3] with one addition: single
line if-statements must be wrapped in braces.

Although the LTTng code base is primarily written in C, it does
contain Perl, Python and Java code. There are no official coding
standards for these languages. However, using a style consistent with
the rest of the code written in that language is strongly encouraged.

Creating and sending a patch
-------------

LTTng's development flow is primarily e-mail based. Like a lot of open
source projects, patches are submitted and reviewed on the project's
mailing list (lttng-dev@lists.lttng.org). This list is also used to
share and comment on RFCs and answer users' questions.

To make patch management and reviews as painless as possible, we
encourage contributors to follow a uniform patch submission process.

Once your changes have been committed to your local branch, use Git's
format-patch command to generate a patch file. The following command
line will generate a patch from the latest commit: git format-patch
-N1 -s --subject-prefix=3D"PATCH project_name"

The patch's subject (the commit message's first line) should be
written in the present tense and not exceed 72 characters in length.

The commit message's body should be as detailed as possible and
explain the reasons behind the proposed change. Any related bug
report(s) should be mentioned at the end of the message.

The lttng-tools project provides a script (checkpatch.pl) as part of
the "extras" that performs a number of checks on a patch to ensure it
is ready for submission. Run this script on your patch and correct any
reported errors before posting it to the mailing list.

You may find an example of a patch suitable for submission here[4].

Note that patches should be as focused as possible. Do not, for
instance, fix a bug and correct the indentation of an unrelated block
of code as part of the same patch.

Once you are confident your patch meets the required guide lines, you
may use Git's send-email command to send your patch on the mailing
list. Make sure you are subscribed[5] to the mailing list to follow
and take part in discussions about your changes.

You may join the file to an e-mail as an attachment if you can't send
the patch directly using send-email.

Reviews
-------------

Once your patch has been posted to the mailing list, other
contributors may propose modifications to your patch. This is
completely normal. This collaborative code review is an integral part
of our development process.

Keep in mind that reviewing patches is a time-consuming process and,
as such, may not be done right away. The delays may be affected by the
current release cycle phase and the complexity of the proposed
changes. If you think your patch might have been forgotten, please
mention it on the #lttng[6] IRC channel rather than resubmitting.

Release cycle
-------------

The LTTng project follows a release cycle that alternates between
development and release candidate (RC) phases. The master branch is
feature-frozen during RC phases; only bug fixes will be accepted
during this period. However, patches adding new functionality may
still be submitted and reviewed during the RC.
The upcoming features and release dates are announced in a monthly
digest posted on the mailing list.


[1] http://git-scm.com
[2] http://lttng.org/download
[3] http://www.kernel.org/doc/Documentation/CodingStyle
[4] http://lists.lttng.org/pipermail/lttng-dev/2013-June/020574.html
[5] http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
[6] irc://irc.oftc.net/lttng

-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
