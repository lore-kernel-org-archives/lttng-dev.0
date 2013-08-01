From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Thu, 1 Aug 2013 13:28:56 -0400
Message-ID: <51FA9AD8.4010502__14697.4544892602$1375378206$gmane$org@mentor.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V4wgT-0007Bu-3s
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 13:29:10 -0400
In-Reply-To: <alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 08/01/2013 01:19 PM, Alexander Monakov wrote:
> =

> =

> On Thu, 1 Aug 2013, Alexander Monakov wrote:
> =

>> Okay, one more hack :)
>>
>> Recurse *once* by calling dlsym inside your calloc, and terminate recurs=
ion by
>> obtaining memory from mmap.
> =

> Correction: since there's no guarantee that the very first calloc invocat=
ion
> will happen from inside dlsym, you have to recurse twice, not once, to be=
 sure
> that there are two dlsyms on the stack.

I don't think any of this works. The ultimate problem is the one J=E9r=E9mie
reported initially: dlsym will eventually call free() on the memory
calloc() returned, so my calloc fallback needs to return something that
can actually be freed.

	Stefan

-- =

Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
