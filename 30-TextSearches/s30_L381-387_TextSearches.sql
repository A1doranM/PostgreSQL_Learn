select to_tsvector('The quick brown fox jumped over the lazy dog.');
select to_tsvector('Very powerfull power powering walking.') @@ to_tsquery('power');
select to_tsvector('Very powerfull power powering walking.') @@ to_tsquery('power & very');
select to_tsvector('Very powerfull power powering walking.') @@ to_tsquery('power | powering');
select to_tsvector('Very powerfull power powering walking.') @@ to_tsquery('!tiger');
select to_tsvector('Very powerfull power powering walking.') @@ to_tsquery('powerfull <-> powering');
