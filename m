From: David Goulet <dgoulet@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
 restore
Date: Thu, 5 Dec 2013 12:52:49 -0500
Message-ID: <20131205175249.GA22343__29906.3653605574$1386266021$gmane$org@thessa>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
	<52A0B401.8020202@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379713705=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vod6g-00010B-Nf
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 12:53:03 -0500
In-Reply-To: <52A0B401.8020202@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1379713705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05 Dec (12:12:33), Julien Desfossez wrote:
> Hi,
>=20
> [...]
>=20
> >=20
> > LTTng Command Line - Daemon Configuration
> > -----------------------------------------
> >=20
> > On launch, the session, relay and consumer daemons will search for file=
s with
> > the .conf extension in the following folders, in order of precedence:
> > 1) Any path specified using a new --load-config option
> Why "load" ?
> Why not --config (like openvpn for example) ?
> -c or -f would be also good for short options.

Agree, --config is better and more common.

>=20
> > 2) $HOME/.lttng/*.conf
> > 3) /etc/lttng/*.conf
> >=20
> >=20
> > Session Configuration File Format
> > ---------------------------------
> >=20
> > The LTTng session configuration file format must enable the serializati=
on of the
> > session, channel and event structures of the LTTng API. Since these con=
cepts
> > are eminently hierarchical, it only makes sense to use a file format th=
at can
> > express such relationships.
> >=20
> > While an INI based file format was the first considered, for its ease o=
f use
> > and human readability, it appears that INI provides no standard way of
> > expressing hierarchies. It is, of course, possible to flatten session/c=
hannel
> > hierarchies using prefixed section names, but this is both error prone =
and
> > unsupported by most INI file reading libraries. This means that we woul=
d have
> > to code our own INI handling code and produce a specification to docume=
nt our
> > additions to the INI format. INI also provides no standard versioning m=
echanism.
> >=20
> > In keeping with the desire to use a human-readable format, we have cons=
idered
> > rolling our own format. This format could express hierarchy using tabul=
ations
> > to delimit scopes, not unlike the Python language. Such a format would =
be both
> > relatively easy to parse, but also readable. However, this both requires
> > documenting the format in a specification, rolling our own parsing and
> > validation code, thus losing the benefit of reusing external libraries.=
 This
> > option has the highest maintenance cost considering the amount of code =
and
> > documentation to be produced while presenting marginal benefits over th=
e INI
> > approach.
> Also, we will have fun with debugging the tab vs space issues.
> =09
> >=20
> > Finally, it seems that using a standard hierarchical format such as JSO=
N or
> > XML would be the most appropriate choice. Both of these formats have in=
trinsic
> > support for representation of hierarchical relationships. They also ben=
efit from
> > having a lot of hardened external libraries that will provide parsing,
> > validation and write support. This is a huge advantage from both
> > maintainability and interoperability standpoints. However, both formats
> > present the disadvantage of being harder, although minimally, to edit m=
anually.
> > It remains to be seen if manual editing of session configurations reall=
y is an
> > important use-case. Using lttng's save feature would probably prove more
> > convenient than editing the files manually. Furthermore, the addition o=
f a
> > "dry-run" option to the lttng client would significantly alleviate this=
 pain
> > point.
> >=20
> > XML seems like a better option than JSON since it makes it possible to =
have
> > robust file validation using a pre-defined schema. The use of version-s=
pecific
> > schemas could also be beneficial for backward compatibility as the form=
at
> > moves forward. Finally, character encoding handling is already a solved
> > problem for most XML libraries.
> >=20
> >=20
> > LTTng ABI/API
> > -------------
> >=20
> > Two new functions are added to the lttng.h API.
> >=20
> > int lttng_load_sessions(const char *url, const char *session_name,
> > int flags/struct lttng_session_load_attr *attr);
> >=20
> > Load sessions. If url the is a directory, all .lttng files it contains =
will be
> > loaded. If session_name is NULL, all sessions found in url are restored.
> > If a session_name is provided, only this session will be restored.
> >=20
> > A supplementary argument, either a "flags" argument or an attribute str=
ucture,
> > is used to indicate whether or not the sessions currently known to the
> > session daemon should be replaced by the ones found in the configuration
> > file(s), provided that their names are the same.
> > Even though this is the only current use-case for this argument, a stru=
cture
> > with a reasonable amount of padding may be more suitable than a primary
> > type to accommodate new features. Thoughts?
> Would it be possible instead, to have an enum and a len field, to avoid
> padding issues ?

Depending if that call needs a payload or not at some point in time for
a specific option, I would go for either using a "int optname + void
*data" or an opaque data structure with getter/setter.

There is one use case that I have in mind where a user could want to
receive the configuration of a specific session inline meaning in a
given string for instance.

>=20
> >=20
> >=20
> > int lttng_save_sessions(const char *url, const char *session_name
> > int flags/struct lttng_session_save_attr *attr);
> >=20
> > Save sessions. If url is a directory, the session configuration will be=
 saved
> > as session_name.lttng. If a complete file name is provided, the session=
(s) to be
> > saved will be written to this file. If session_name is NULL, all sessio=
ns
> > currently known to the session daemon will be saved. If a name is provi=
ded, only
> > that session will be saved.
> >=20
> > The reasoning for the flags/attr argument is the same as for the
> > lttng_load_sessions() function, but for a configuration file overwrite
> > option.
> >=20
> In save and load, can the URL be a network URL (like the net:// we have) ?
> I can easily see a use-case for that in the future, where we would have
> a repository of session configurations. Especially in cloud/large-scale
> deployments.
> I don't think we should rush into implementing that, but having the
> interface easy to extend would be interesting.

This is exactly why there is a "url" there. :)

>=20
> >=20
> > LTTng Command Line - Session Configuration
> > ------------------------------------------
> >=20
> > Tracing session configurations can be saved and restored using the lttn=
g command
> > line client. This capability introduces two new command line options.
> >=20
> >=20
> > -- Load session configurations --
> >=20
> > $ lttng load -s SESSION_NAME [OPTIONS]
> >=20
> > Loads tracing session configurations.
> >=20
> > .lttng files will be searched in the following default paths, in order =
of
> > precedence:
> > 1) $(HOME)/.lttng/sessions
> > 2) /etc/lttng/sessions
> >=20
> > A session name or the -a option must be passed as the SESSION_NAME argu=
ment.
> > Like some other lttng commands, such as enable-event, the -a option sta=
nds for
> > "all". If this option is used, every session found in the paths will be=
 loaded.
> >=20
> > If a session was saved as active, the tracing for that session will be =
activated
> > automatically on load. The current session configuration of the session=
 daemon
> > is also preserved when a configuration is loaded. The new session confi=
gurations
> > are added to the current session set.
> >=20
> > Tracing sessions saved in an active state will be resumed on load.
> >=20
> > --input-path, -i
> > Path in which to search for SESSION_NAME's description. If the path is a
> > directory, all .lttng files it contains will be opened and searched for
> > SESSION_NAME. If an input path is provided, the -a option will load all
> > session configurations found in this path. The default paths are ignore=
d when
> > this option is used.
> Can we have multiple paths separated by ":" (like $PATH) ?
> Also, if we have a configuration path already specified in the sessiond
> configuration file, will we override or merge the search paths with -i ?

Hrm... seems a bit intense, maybe we can allow multiple -i ?

>=20
> >=20
> > --force, -f
> > If a restored session's name conflicts with a currently existing sessio=
n, the
> > original session configuration is preserved. However, if the --force op=
tion is
> > used, the restored session takes precedence. The original session will =
be
> > destroyed.
> >=20
> >=20
> > -- Save session configurations --
> >=20
> > $ lttng save -s SESSION_NAME [OPTIONS]
> >=20
> > Saves tracing configurations.
> >=20
> > The selected tracing session's configuration will be saved in the
> > $HOME/.lttng/sessions folder. If the -a option is used, every session k=
nown
> > to the session daemon will be saved.
> I wonder if we will have trouble with saving only the sessions of our
> user (if a root sessiond is running). I think -a will save everything
> regardless of the user. Not sure if it is a problem, but we could maybe
> specify a uid as well if we want to save all the sessions of a
> particular user ?

The credentials of the API call are passed to the session daemon so
those only will be saved. Thus if you are in the tracing group, you can
talk to the root session daemon but will only be able to save YOUR
session.

This is a good question, do we want to allow anyone in the tracing group
to save *every* session on the root one. I'm not to sure about that.

Cheers!
David

>=20
> >=20
> > --output-path, -o
> > If the provided output path is a directory, the session will be saved i=
n a
> > file named "SESSION_NAME.lttng". However, if the path is a file, the se=
ssion(s)
> > will all be saved in the same file.
> >=20
> >=20
>=20
> It looks good !
>=20
> I can't wait to have that for lttngtop ;-) !
>=20
> Thanks,
>=20
> Julien
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSoL1xXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02jTQIALt1cNSOe2O2Epuw6MhocPeq
wkaGgYdi7A8RlB6wNGx0+KuarNsrW3Fx/KzNozNZYe4mkg0y20hPB1BVd4d8QWTA
mgcTheNArqU30Ms6YZwi9GxZG3Qv06rcKwm9/LjmwPd6eQxjakpDvLg7OjBHahKc
11hseK0rnBkspxi/W0uBeyBDIw2JtqGH8nW2RaqkHVsg9EazZfCJLSfxPtWWqicg
kl2xrSF5qE5fz1L6vkvTyF1estUG3aAIavOcih3nW9Z212dP2nw7qJDzg8sUrRJ8
Epy+dEFV+q1YGUhMszhTtxB5bcb80dMUE7aqROglupkuPRPnlC7ZP+IrAaXdaKM=
=0mAu
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============1379713705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1379713705==--
