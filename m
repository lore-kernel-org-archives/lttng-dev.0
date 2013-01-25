From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1/2] Add missing shebangs to
	Python examples.
Date: Fri, 25 Jan 2013 16:03:12 +0000
Message-ID: <CA+jJMxuo=r+k+yPdNneE_W9J86pwRgOF9R9=mo8QfMwZO4peOw__24140.2322463275$1359129840$gmane$org@mail.gmail.com>
References: <1358898446-1622-1-git-send-email-jeremie.galarneau@efficios.com>
	<20130123144550.GA3952@Krystal>
	<CAGDH53=N1Ae2cLr5UEDeMBBGwN+pTTwf+dnhTpriPGJ+oL4huA@mail.gmail.com>
	<CA+jJMxvqEXqgK8oMmJZT5WKiKuNYm7Wws47QOi=e2wzYnaKH8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1TylkN-0000vI-KI
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 11:03:19 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so843433iaf.28
	for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2013 08:03:13 -0800 (PST)
In-Reply-To: <CA+jJMxvqEXqgK8oMmJZT5WKiKuNYm7Wws47QOi=e2wzYnaKH8A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Looks like this patch will require more work since it was decided we
only want to explicitly support Python3. I'll have to look into the
examples and see what can be ported and fixed. I'll also work on
having a more comprehensive test suite in preparation for an eventual
merge into master.

However, please note that the second patch from this series - [PATCH
babeltrace 2/2] Fix: Unified types expected by the Definition Python
interface. - will remain unchanged and should be pulled as it fixes a
bug that prevented the Python iterator tests from passing.

Regards,
J=E9r=E9mie

On Wed, Jan 23, 2013 at 5:21 PM, J=E9r=E9mie Galarneau
<jeremie.galarneau@gmail.com> wrote:
>> I would recommend using "#!/usr/bin/env python" so it will default to
>> the Python interpreter available on the machine. Take note that we
>> might have issues with Python 3 interpreters if the scripts are not
>> fully compliant.
>
> It does seem like some of the example scripts are not Python 3
> compatible. However, forcing the use of Python 2 on distros wich use
> Python 3 as the default interpreter is far from ideal... I'll see if I
> can make them version agnostic before resubmitting.
>
> Thanks,
> J=E9r=E9mie
