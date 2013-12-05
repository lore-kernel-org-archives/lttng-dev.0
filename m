From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: RFC LTTng session and daemon configuration save and
	restore
Date: Thu, 5 Dec 2013 13:07:31 -0500
Message-ID: <CA+jJMxukuqut2xhTwFRmGMmZ1=191GcoPhdaGaT2CydZJ-4P6w__48746.7884821401$1386266903$gmane$org@mail.gmail.com>
References: <CA+jJMxv-mg_Lx1DdZHq7LyETNmULZ=MMKUoHqMhc5t3o9BJRkg@mail.gmail.com>
	<52A0B401.8020202@efficios.com> <20131205175249.GA22343@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VodKr-0001B0-0B
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 13:07:43 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so3843573qcz.16
	for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2013 10:07:31 -0800 (PST)
In-Reply-To: <20131205175249.GA22343@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 5, 2013 at 12:52 PM, David Goulet <dgoulet@efficios.com> wrote:
> On 05 Dec (12:12:33), Julien Desfossez wrote:
>> Hi,
>>
>> [...]
>>
>> >
>> > LTTng Command Line - Daemon Configuration
>> > -----------------------------------------
>> >
>> > On launch, the session, relay and consumer daemons will search for fil=
es with
>> > the .conf extension in the following folders, in order of precedence:
>> > 1) Any path specified using a new --load-config option
>> Why "load" ?
>> Why not --config (like openvpn for example) ?
>> -c or -f would be also good for short options.
>
> Agree, --config is better and more common.
>
>>
>> > 2) $HOME/.lttng/*.conf
>> > 3) /etc/lttng/*.conf
>> >
>> >
>> > Session Configuration File Format
>> > ---------------------------------
>> >
>> > The LTTng session configuration file format must enable the serializat=
ion of the
>> > session, channel and event structures of the LTTng API. Since these co=
ncepts
>> > are eminently hierarchical, it only makes sense to use a file format t=
hat can
>> > express such relationships.
>> >
>> > While an INI based file format was the first considered, for its ease =
of use
>> > and human readability, it appears that INI provides no standard way of
>> > expressing hierarchies. It is, of course, possible to flatten session/=
channel
>> > hierarchies using prefixed section names, but this is both error prone=
 and
>> > unsupported by most INI file reading libraries. This means that we wou=
ld have
>> > to code our own INI handling code and produce a specification to docum=
ent our
>> > additions to the INI format. INI also provides no standard versioning =
mechanism.
>> >
>> > In keeping with the desire to use a human-readable format, we have con=
sidered
>> > rolling our own format. This format could express hierarchy using tabu=
lations
>> > to delimit scopes, not unlike the Python language. Such a format would=
 be both
>> > relatively easy to parse, but also readable. However, this both requir=
es
>> > documenting the format in a specification, rolling our own parsing and
>> > validation code, thus losing the benefit of reusing external libraries=
. This
>> > option has the highest maintenance cost considering the amount of code=
 and
>> > documentation to be produced while presenting marginal benefits over t=
he INI
>> > approach.
>> Also, we will have fun with debugging the tab vs space issues.
>>
>> >
>> > Finally, it seems that using a standard hierarchical format such as JS=
ON or
>> > XML would be the most appropriate choice. Both of these formats have i=
ntrinsic
>> > support for representation of hierarchical relationships. They also be=
nefit from
>> > having a lot of hardened external libraries that will provide parsing,
>> > validation and write support. This is a huge advantage from both
>> > maintainability and interoperability standpoints. However, both formats
>> > present the disadvantage of being harder, although minimally, to edit =
manually.
>> > It remains to be seen if manual editing of session configurations real=
ly is an
>> > important use-case. Using lttng's save feature would probably prove mo=
re
>> > convenient than editing the files manually. Furthermore, the addition =
of a
>> > "dry-run" option to the lttng client would significantly alleviate thi=
s pain
>> > point.
>> >
>> > XML seems like a better option than JSON since it makes it possible to=
 have
>> > robust file validation using a pre-defined schema. The use of version-=
specific
>> > schemas could also be beneficial for backward compatibility as the for=
mat
>> > moves forward. Finally, character encoding handling is already a solved
>> > problem for most XML libraries.
>> >
>> >
>> > LTTng ABI/API
>> > -------------
>> >
>> > Two new functions are added to the lttng.h API.
>> >
>> > int lttng_load_sessions(const char *url, const char *session_name,
>> > int flags/struct lttng_session_load_attr *attr);
>> >
>> > Load sessions. If url the is a directory, all .lttng files it contains=
 will be
>> > loaded. If session_name is NULL, all sessions found in url are restore=
d.
>> > If a session_name is provided, only this session will be restored.
>> >
>> > A supplementary argument, either a "flags" argument or an attribute st=
ructure,
>> > is used to indicate whether or not the sessions currently known to the
>> > session daemon should be replaced by the ones found in the configurati=
on
>> > file(s), provided that their names are the same.
>> > Even though this is the only current use-case for this argument, a str=
ucture
>> > with a reasonable amount of padding may be more suitable than a primary
>> > type to accommodate new features. Thoughts?
>> Would it be possible instead, to have an enum and a len field, to avoid
>> padding issues ?
>
> Depending if that call needs a payload or not at some point in time for
> a specific option, I would go for either using a "int optname + void
> *data" or an opaque data structure with getter/setter.
>
> There is one use case that I have in mind where a user could want to
> receive the configuration of a specific session inline meaning in a
> given string for instance.
>
>>
>> >
>> >
>> > int lttng_save_sessions(const char *url, const char *session_name
>> > int flags/struct lttng_session_save_attr *attr);
>> >
>> > Save sessions. If url is a directory, the session configuration will b=
e saved
>> > as session_name.lttng. If a complete file name is provided, the sessio=
n(s) to be
>> > saved will be written to this file. If session_name is NULL, all sessi=
ons
>> > currently known to the session daemon will be saved. If a name is prov=
ided, only
>> > that session will be saved.
>> >
>> > The reasoning for the flags/attr argument is the same as for the
>> > lttng_load_sessions() function, but for a configuration file overwrite
>> > option.
>> >
>> In save and load, can the URL be a network URL (like the net:// we have)=
 ?
>> I can easily see a use-case for that in the future, where we would have
>> a repository of session configurations. Especially in cloud/large-scale
>> deployments.
>> I don't think we should rush into implementing that, but having the
>> interface easy to extend would be interesting.
>
> This is exactly why there is a "url" there. :)
>
>>
>> >
>> > LTTng Command Line - Session Configuration
>> > ------------------------------------------
>> >
>> > Tracing session configurations can be saved and restored using the ltt=
ng command
>> > line client. This capability introduces two new command line options.
>> >
>> >
>> > -- Load session configurations --
>> >
>> > $ lttng load -s SESSION_NAME [OPTIONS]
>> >
>> > Loads tracing session configurations.
>> >
>> > .lttng files will be searched in the following default paths, in order=
 of
>> > precedence:
>> > 1) $(HOME)/.lttng/sessions
>> > 2) /etc/lttng/sessions
>> >
>> > A session name or the -a option must be passed as the SESSION_NAME arg=
ument.
>> > Like some other lttng commands, such as enable-event, the -a option st=
ands for
>> > "all". If this option is used, every session found in the paths will b=
e loaded.
>> >
>> > If a session was saved as active, the tracing for that session will be=
 activated
>> > automatically on load. The current session configuration of the sessio=
n daemon
>> > is also preserved when a configuration is loaded. The new session conf=
igurations
>> > are added to the current session set.
>> >
>> > Tracing sessions saved in an active state will be resumed on load.
>> >
>> > --input-path, -i
>> > Path in which to search for SESSION_NAME's description. If the path is=
 a
>> > directory, all .lttng files it contains will be opened and searched for
>> > SESSION_NAME. If an input path is provided, the -a option will load all
>> > session configurations found in this path. The default paths are ignor=
ed when
>> > this option is used.
>> Can we have multiple paths separated by ":" (like $PATH) ?
>> Also, if we have a configuration path already specified in the sessiond
>> configuration file, will we override or merge the search paths with -i ?
>
> Hrm... seems a bit intense, maybe we can allow multiple -i ?
>
>>
>> >
>> > --force, -f
>> > If a restored session's name conflicts with a currently existing sessi=
on, the
>> > original session configuration is preserved. However, if the --force o=
ption is
>> > used, the restored session takes precedence. The original session will=
 be
>> > destroyed.
>> >
>> >
>> > -- Save session configurations --
>> >
>> > $ lttng save -s SESSION_NAME [OPTIONS]
>> >
>> > Saves tracing configurations.
>> >
>> > The selected tracing session's configuration will be saved in the
>> > $HOME/.lttng/sessions folder. If the -a option is used, every session =
known
>> > to the session daemon will be saved.
>> I wonder if we will have trouble with saving only the sessions of our
>> user (if a root sessiond is running). I think -a will save everything
>> regardless of the user. Not sure if it is a problem, but we could maybe
>> specify a uid as well if we want to save all the sessions of a
>> particular user ?
>
> The credentials of the API call are passed to the session daemon so
> those only will be saved. Thus if you are in the tracing group, you can
> talk to the root session daemon but will only be able to save YOUR
> session.
>
> This is a good question, do we want to allow anyone in the tracing group
> to save *every* session on the root one. I'm not to sure about that.

It should probably mimic lttng list's behavior.

>
> Cheers!
> David
>
>>
>> >
>> > --output-path, -o
>> > If the provided output path is a directory, the session will be saved =
in a
>> > file named "SESSION_NAME.lttng". However, if the path is a file, the s=
ession(s)
>> > will all be saved in the same file.
>> >
>> >
>>
>> It looks good !
>>
>> I can't wait to have that for lttngtop ;-) !
>>
>> Thanks,
>>
>> Julien
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
