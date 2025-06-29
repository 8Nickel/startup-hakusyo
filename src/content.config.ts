import { defineCollection, z } from 'astro:content';

const basicSchema = z.object({
  title: z.string(),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  tags: z.array(z.string()).optional(),
  excerpt: z.string().optional(),
});

export const collections = {
  interviews:        defineCollection({ schema: basicSchema }),
  'founders-insight':defineCollection({ schema: basicSchema }),
  trends:            defineCollection({ schema: basicSchema }),
  failures:          defineCollection({ schema: basicSchema }),
  'vc-interviews':   defineCollection({ schema: basicSchema }),
  glossary:          defineCollection({ schema: z.object({ term: z.string(), definition: z.string() }) }),
  news:              defineCollection({ schema: basicSchema }),
};
