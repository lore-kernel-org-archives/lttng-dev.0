From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: RFC LTTng session and daemon configuration save and
 restore
Date: Thu, 5 Dec 2013 08:49:39 +0100
Message-ID: <52A03013.9030604__47353.9896229797$1386229884$gmane$org@mentor.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VoThN-0004Jt-Fk
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 02:50:35 -0500
In-Reply-To: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi J=E9r=E9mie,

On 12/04/2013 10:33 PM, J=E9r=E9mie Galarneau wrote:

> Session Configuration File Format

This is great news. Providing the ability to specify the specifics of a
session as data will benefit command line users as well as IDEs (talking
to lttng).

> ...
> ...
> XML seems like a better option than JSON since it makes it possible to ha=
ve
> robust file validation using a pre-defined schema. The use of version-spe=
cific
> schemas could also be beneficial for backward compatibility as the format
> moves forward. Finally, character encoding handling is already a solved
> problem for most XML libraries.

Just in case you don't know, there is also schema validation for JSON:
http://json-schema.org/
Available in multiple implementations (Java, C, Javascript, ...):
http://json-schema.org/implementations.html

--
Thanks,
Paul
